#!/bin/bash
CURRENTDIR=$(cd "$(dirname "$0")";pwd)
source $CURRENTDIR/../bin/env.sh
source ${K8S_HOME}/properties/images/images.properties

Version() {
    echo "Version: 2018.08"
}

GlobalUsage() {
    echo "Usage: cdfctl [Global options] Command [command options] [arguments...]

Name:
    cdfctl - kubectl for CDF

Version:
    2018.08

Commands:
    runlevel                      Apply runlevel changes

Global Options:
    --help, -h                    Print this help list
    --version, -v                 Print the version
    --follow, -f                  Specify if the logs should be streamed"
}

RunlevelUsage() {
    echo "Usage: cdfctl [Global options] runlevel [Command options] [arguments...]

Name:
    cdfctl runlevel - Manage runlevels

Version:
    2018.08

Commands:
    show           Show current runlevel
    set            Apply runlevel changes
    list           Show supported runlevels

Options:
    --level, -l                   Requested runlevel. One of: DOWN, DB, STANDBY, UP or custom values, -l is mandatory for set
    --namespaces, -n              One or more namespaces separated by commas to apply the runlevel

Global Options:
    --help, -h                    Print this help list
    --version, -v                 Print the version
    --follow, -f                  Specify if the logs should be streamed

Examples:
    ./cdfctl.sh runlevel show
    ./cdfctl.sh runlevel show -n demo1
    ./cdfctl.sh runlevel list
    ./cdfctl.sh runlevel set -l DOWN
    ./cdfctl.sh -f runlevel set -l UP -n demo1
    ./cdfctl.sh runlevel set -l UP -n core,demo1 -f"
}

InvalidGlobalExit() {
    echo "Invalid Global Parameters"
    GlobalUsage
    exit 1
}

InvalidRunlevelExit() {
    echo "Invalid Runlevel Parameters"
    RunlevelUsage
    exit 1
}

StartYaml() {
    local command=$1
    local jobNamePrefix=$2
    timeStamp=`date +%y%m%d%H%M%S`
    local jobName="cdf-runlevel-${timeStamp}"
    if [[ -z "${IMAGE_ITOM_CDF_CONTROLLER}" ]]; then
        echo "No controller image name"
        exit 1
    fi
    orgName=`kubectl get cm -n core base-configmap -o json 2> /dev/null | jq -r .data.REGISTRY_ORGNAME 2> /dev/null`
    if [ $? -ne 0 -o -z "$orgName" ]; then
        echo "Get REGISTRY_ORGNAME ERROR"
        exit 1
    fi
    imageName="localhost:5000/${orgName}/${IMAGE_ITOM_CDF_CONTROLLER}"
    jobYaml="
apiVersion: batch/v1
kind: Job
metadata:
  name: "${jobName}"
spec:
  template:
    spec:
      containers:
      - name: itom-cdf-controller
        image: "${imageName}"
        command: [\"/bin/sh\",\"-c\",\"${command}\"]
      restartPolicy: Never
  backoffLimit: 0
"
    echo -e "$jobYaml" | kubectl create -f -
    if [[ $follow = true ]]; then
        podName=`kubectl get pods --show-all 2> /dev/null | grep $jobName | awk '{print $1}' 2> /dev/null`
        if [ -z podName ]; then
            echo "Unknown error, not found the pod name"
            exit 1
        fi
        until kubectl logs -f $podName 2> /dev/null; do
            continue
        done
    fi
    exit 0
}

setRunlevel() {
    cmd="/cdfctl -f runlevel set"
    if [[ -n "$level" ]]; then
        cmd="${cmd} -l ${level}"
    else
        InvalidRunlevelExit
    fi
    if [[ -n "$namespaces" ]]; then
        OLD_IFS="$IFS"
        IFS=","
        nss=($namespaces)
        IFS="$OLD_IFS"
        k8s_ns=`kubectl get ns -n core -o name 2> /dev/null | cut -d "/" -f 2`
        for ns in ${nss[@]}
        do
            echo "${k8s_ns[@]}" | grep -wq "$ns"
            if [ $? -ne 0 ]; then
                echo "namespace $ns is not existed"
                exit 1
            fi
        done
        cmd="${cmd} -n ${namespaces}"
    fi
    StartYaml "${cmd}"
    exit 0
}

showCurrentRunlevel() {
    printf "%-20s %-10s\n" Namespace Runlevel;
    if [ -n "$namespaces" ]; then
        OLD_IFS="$IFS"
        IFS=","
        nss=($namespaces)
        IFS="$OLD_IFS"
    else
        nss=`kubectl get ns -n core -o name 2> /dev/null | cut -d "/" -f 2 | grep -v kube-public | grep -v kube-system`
    fi

    for ns in ${nss[@]}
    do
        levelJson=`kubectl get cm -n $ns current-runlevel -o json 2>&1`
        if [ $? -ne 0 ]; then
            echo $levelJson | grep -wq "not found"
            if [ $? -eq 0 ]; then
                currentLevel="No current runlevel found"
            else
                currentLevel="Failed to get current-runlevel"
            fi
        else
            currentLevel=`echo $levelJson | jq -r .data.runlevel 2> /dev/null`
        fi
        printf "%-20s %-20s\n" "$ns" "$currentLevel";
    done
    exit 0
}

showSupportedRunlevels() {
    levelsJson=`kubectl get cm -n core supported-runlevels -o json 2>&1`
    if [ $? -ne 0 ]; then
        echo $levelsJson | grep -wq "not found"
        if [ $? -eq 0 ]; then
                supportedRunlevels="DOWN DB STANDBY UP"
            else
                supportedRunlevels="Failed to get supportedRunlevels"
            fi
    else
        supportedRunlevels=`echo $levelsJson | jq -r .data.runlevels 2> /dev/null`
        checkSupportedRunlevels "$supportedRunlevels"
    fi
    echo $supportedRunlevels
    exit 0
}

checkSupportedRunlevels() {
    local supportedRunlevels=($1)
    local standard=""
    local length=${#supportedRunlevels[@]}
    local last=$(( length-1 ))
    if [ "${supportedRunlevels[0]}" != "DOWN" -o "${supportedRunlevels[${last}]}" != "UP" ]; then
        echo "Warning: Supported runlevels are in wrong format"
        exit 1
    fi
    for rl in ${supportedRunlevels[@]}
    do
        if [ "$rl" == "DOWN" -o "$rl" == "DB" -o "$rl" == "STANDBY" -o "$rl" == "UP" ]; then
            standard=${standard}${rl}
        fi
    done
    if [ "$standard" != "DOWNDBSTANDBYUP" ]; then
        echo "Warning: Supported runlevels are in wrong format"
        exit 1
    fi
}

#main
follow=false

while [ ! -z $1 ]; do
    case "$1" in
        runlevel)
            command="runlevel"
            shift 1
            break
        ;;
        -f|--follow) follow=true; shift 1
        ;;
        -h|--help) GlobalUsage; exit 0
        ;;
        -v|--version) Version; exit 0
        ;;
        *) InvalidGlobalExit
        ;;
    esac
done

while [ ! -z $1 ]; do
    case "$1" in
    set) runlevelCmd="set"; shift 1
    ;;
    show) runlevelCmd="show"; shift 1
    ;;
    list) runlevelCmd="list"; shift 1
    ;;
    -n|--namespaces)
        case "$2" in
            -*) InvalidRunlevelExit
            ;;
            * ) if [ -z $2 ];then InvalidRunlevelExit; fi; namespaces=$2; shift 2
            ;;
        esac
    ;;
    -l|--level)
        case "$2" in
            -*) InvalidRunlevelExit
            ;;
            * ) if [ -z $2 ];then InvalidRunlevelExit; fi; level=$2; shift 2
            ;;
        esac
    ;;
    -f|--follow) follow=true; shift 1
    ;;
    -h|--help) RunlevelUsage; exit 0
    ;;
    -v|--version) Version; exit 0
    ;;
    *) InvalidRunlevelExit
    ;;
    esac
done

case $command in
    runlevel)
        case "$runlevelCmd" in
            set) setRunlevel
            ;;
            show) showCurrentRunlevel
            ;;
            list) showSupportedRunlevels
            ;;
        esac
    ;;
esac
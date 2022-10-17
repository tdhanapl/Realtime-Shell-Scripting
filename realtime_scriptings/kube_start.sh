cat kube-start.sh
#!/bin/sh

usage() {
    echo "This action will start all container runtime services (Docker, Kubernetes, ITOM CDF and/or suite containers) on this node."
    echo "Usage: $0 "
    echo "       -h,--help           Print this help list."
    exit 1
}

while [[ ! -z $1 ]] ; do
    case "$1" in
        *|-h|--help|/?|help) usage ;;
    esac
done

##start k8s
COMMON_SH=$(cd "$(dirname "$0")";pwd)/kube-common.sh
ENV_SH=$(cd "$(dirname "$0")";pwd)/env.sh
LOGFILE=/tmp/kube-start-`date "+%Y%m%d%H%M%S"`.log

#start Docker
startNativeService() {
    svcName=$1
    showName "Starting service $svcName"
    exec_cmd "systemctl daemon-reload" -x=INFO
    exec_cmd "systemctl start $svcName >/dev/null 2>&1 &" -x=INFO
    checkNativeService $svcName
}

checkNativeService(){
#check if started
    n=0
    while true; do
        waiting
        systemctl status $svcName >/dev/null 2>&1
        if [ "$?" == 0 ]; then
            showStatus "Started"
            exec_cmd "systemctl status $svcName -l" -x=INFO
            break
        else
            if (( n > $TIMEOUT )); then
                showStatus "Timeout"
                exec_cmd "systemctl status $svcName -l" -x=FATAL
                echo -e "\nFor more detail information, please refer to $LOGFILE\n"
                exit 2
            fi
            n=$((n+1))
        fi
        waiting
    done
}

isMasterNode(){
    local isMaster=
    if [[ -d ${K8S_HOME}/data/etcd ]] && [[ -d ${K8S_HOME}/log/apiserver ]] && [[ $(exec_cmd "ls ${K8S_HOME}/data/etcd|wc -l" -p=true) -gt 0 ]] ; then
        isMaster=true
    else
        isMaster=false
    fi
    echo $isMaster
}

loadCDFImages() {
    local k8s_home=${K8S_HOME}
    if [[ "${k8s_home:$((-1))}" != "/" ]] ; then
        k8s_home="${k8s_home}/"
    fi
    local image_property_dir=${k8s_home}properties/images
    source ${image_property_dir}/images.properties
    local is_master=$(isMasterNode)
    local images
    if [ "$is_master" == "true" ] ; then
        images=(${IMAGE_ITOM_CDF_APISERVER} ${IMAGE_ITOM_CDF_SUITEFRONTEND} ${IMAGE_KUBERNETES_VAULT} ${IMAGE_KUBERNETES_VAULT_INIT} ${IMAGE_KUBERNETES_VAULT_RENEW} ${IMAGE_KUBE_REGISTRY_PROXY} ${IMAGE_ITOM_REGISTRY} ${IMAGE_ITOM_BUSYBOX} ${IMAGE_HYPERKUBE} ${IMAGE_K8S_DNS_KUBE_DNS_AMD64} ${IMAGE_K8S_DNS_SIDECAR_AMD64} ${IMAGE_K8S_DNS_DNSMASQ_NANNY_AMD64} ${IMAGE_PAUSE_AMD64} ${IMAGE_KEEPALIVED})
    else
        images=(${IMAGE_KUBERNETES_VAULT_INIT} ${IMAGE_KUBERNETES_VAULT_RENEW} ${IMAGE_KUBE_REGISTRY_PROXY} ${IMAGE_PAUSE_AMD64} ${IMAGE_ITOM_BUSYBOX})
    fi
    local image_dir="${k8s_home}images"

    local repository
    local image_full_name
    local newlineIFS=$'\n'
    local firstTime="true"
    for im in ${images[@]} ; do
        local image_name=${im%:*}
        local image_tag=${im##*:}
        if [ "${image_name}" == "hyperkube" -o "${image_name}" == "k8s-dns-sidecar-amd64" -o "${image_name}" == "k8s-dns-kube-dns-amd64" -o "${image_name}" == "k8s-dns-dnsmasq-nanny-amd64" -o "${image_name}" == "pause-amd64" ] ; then
            repository="gcr.io/google_containers"
        else
            repository="localhost:5000"
        fi

        local found="false"
        local line
        local IFS="$newlineIFS"

        #several lines may match
        for line in `docker images | grep "${repository}/${image_name}" | grep "${image_tag}"`
        do
            local name=$(echo "$line" | awk -F' ' '{print $1}')
            local tag=$(echo "$line" | awk -F' ' '{print $2}')

            if [ "${name}" == "${repository}/${image_name}" ] && [ "${tag}" == "${image_tag}" ] ; then
                found="true"
                break
            fi
        done

        if [ "${found}" == "true" ] ; then
            continue
        else    #not found in the docker graph driver
            if [ "${firstTime}" == "true" ] ; then
                firstTime="false"
                echo ""
                echo "Some of the basic images are missing,try to reload:"
            fi

            res=$(ls ${image_dir} | grep "${image_name}" 2>/dev/null | wc -l)
            if [[ ${res} -eq 0 ]] ; then
                showName "Loading image:$im"
                showStatus "Failed"
                logger_err "image:${image_name}-${image_tag} no found in ${image_dir}"
                exit 1
            else
                #several images may match, and load them all
                for line in `ls ${image_dir} | grep "${image_name}" 2>/dev/null`
                do
                    showName "Loading image:$line"
                    image_full_name=${image_dir}/${line}
                    docker load -i ${image_full_name} >> $LOGFILE 2>/dev/null
                    if [[ $? -ne 0 ]] ; then
                        showStatus "Failed"
                        logger_err "fail to load image:${image_full_path}"
                        exit 1
                    fi
                    if [ "${image_name}" == "itom-busybox" ] ; then
                        org_name=${REGISTRY_ORGNAME}
                        docker tag ${repository}/${image_name}:${image_tag}    ${repository}/${org_name}/${image_name}:${image_tag}
                        if [[ $? -ne 0 ]] ; then
                            showStatus "Failed"
                            logger_err "retag image failed:${image_name}"
                            exit 1
                        fi
                    fi
                    showStatus "Done"
                done
            fi
        fi
    done

    if [ "$firstTime" = "false" ] ; then
        echo ""
    fi
}

if [ ! -f $COMMON_SH  -o ! -f $ENV_SH ]
then
        echo Not found $COMMON_SH or $ENV_SH!
        exit 1
fi
. $COMMON_SH
. $ENV_SH

startNativeService docker-bootstrap
sleep 5
startNativeService docker
sleep 5
loadCDFImages
startNativeService kubelet
sleep 5
startNativeService kube-proxy

echo
echo "Docker is restarted. Please check the pod Status with kube-status.sh in a few seconds"

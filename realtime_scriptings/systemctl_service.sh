######################################To check the service status###################################
#!/bin/bash
tput setf 2
#read -p "Enter start,stop,status,enabled,and Disabled  to perform action on  services: " action
#read -p "Enter the Service name=" Service_name
#Systemtcl=$(systemctl ${action} ${Service_name})
#if [ "${action}" == "start" ]
#then
#echo "${action} ${Service_name}...."
#echo"$Systemtcl" # systemctl ${action} $(Service_name)
#echo -e  "this show the status\033[96m $status\033[0m"
#echo "${action} ${Service_name} is start"
#fi

#if [ "${action}" == "stop" ]
#then
# echo "${action} ${Service_name}..........."
#echo "$Systemtcl" # systemctl ${action} $(Service_name)
#echo -e  "this show the status\033[96m $status\033[0m"
#echo "${action} ${Service_name} stop status showing"
#fi


#if [ "${action}" == "status" ]
#then
# echo "stopping ${Service_name}..."
# echo"$Systemtcl" # systemctl ${action} $(Service_name)
# echo -e  "this show the status\033[96m $status\033[0m"
# echo "${action} ${Service_name}"
#fi
                #or
#!/bin/bash
read -p "Enter start,stop,status,enabled,and Disabled  to perform action on  services: " action
read -p "Enter the Service name=" Service_name
Systemtcl=$(systemctl ${action} ${Service_name})

#Assume variable a holds 10 and variable b holds 20 then −
# -o	This is logical OR. If one of the operands is true, then the condition becomes true.	[ $a -lt 20 -o $b -gt 100 ] is true.

if [ "${action}" == "start" -o  "${action}" == "stop" -o  "${action}" == "status" -o  "${action}" == "enable" -o  "${action}" == "disable" ]
then
echo "${action} ${Service_name}...."
echo "$Systemtcl" # systemctl ${action} $(Service_name)
echo 
echo "${action} of  ${Service_name} .... "
fi

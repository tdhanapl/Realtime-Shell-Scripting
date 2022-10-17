#!/bin/bash
tput setf 2
hostname=$(hostname)
cpu_usage=$(top -b -n 2 -d1 | grep -i "cpu(s)" | tail -n1 | awk '{print $2}'  | awk -F . '{print $1}')
mail=dhanapal70378@gmail.com
if [ $cpu_usage -ge 75 ] ; 
then
	echo " send a mail to dhanapal703278@gmail.com $hostname is reached cpu usage is  above 75%"
	echo "clear the space"
else
	echo "cpu usage is below 75%"
fi

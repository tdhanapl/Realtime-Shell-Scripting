#!/bin/bash
tput setf 2
hostname=$(hostname)
filespace=$(df -h  |grep -ivE "filesystem|tmpfs" | sed 's/%//gI' | awk '{print $5}')
mail=dhanapal70378@gmail.com
if [ $filespace -ge 75 ] ; then
	echo " send a mail to dhanapal703278@gmail.com $hostname is reached filesystem above 75%"
	echo "clear the space"
else
echo "filesystem space is below 75%"
fi

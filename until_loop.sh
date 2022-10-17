#!/bin/bash
tput setf 2
read -p "please enter the ip address to ping: " ipaddress
until ping -c 3 $ipaddress
do
	echo "host  $ipaddress is still down"
	sleep 1
done
echo "host $ipaddress is up now"

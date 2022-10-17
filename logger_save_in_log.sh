#!/bin/bash
df -h > /tmp/disk.txt
status=`echo "$?"`
if [ $status -eq 0 ]; then
	logger "sucessfully excute" -t LoggerScript -f /var/log/messages
else 
	logger "failed to excute df command" -t LoggerScript -f /var/log/messages
fi

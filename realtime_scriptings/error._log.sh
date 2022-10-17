
#!/bin/bash
#path=$(cat /var/log/logstash/logstash-plain.log | grep -io "Connection to graphite server died | wc-l "
path=$(cat log.txt |grep -io "Connection to graphite server died" | wc -l)
error="Connection to graphite server died"
service_name="syslog.service"
if [ "$path" -ge 1  ]
then
        echo "error ${error} find in the log file"
        echo "due error in the log file  stopping the service ${service_name} "
        systemctl stop ${service_name}
else
        echo "didn't find error in the log"
fi
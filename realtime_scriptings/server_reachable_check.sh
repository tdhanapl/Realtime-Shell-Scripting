####server reacheable check with ip is ping or not##
#!/bin/bash
tput setf 2
host=/opt/hostipaddress #( hostip address in file)
for ip in $(cat $host)
do
   ssh  $ip
   if [ $? == 0 ]
   then
   echo "$ip is remotely login"
   top -b -o +%MEM | head -n 30 > /var/cpu-loadaverage.log
   exit
   else
   echo "$ip is unable to ssh "
   fi
done
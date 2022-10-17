###Listing all available machines on a network##########
#!/bin/bash
#Filename: ping.sh
# Change base address 192.168.0 according to your network.
for ip in 10.2.247.{1..255} ;
do
 ping $ip -c 2 &> /dev/null ;
 if [ $? -eq 0 ];
 then
 echo $ip is alive
 else 
 echo $ip is not alive
 fi
done
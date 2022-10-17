#!/bin/bash
tput setf 2
#Author=
#Purpose=
#Creation date=
#Modificaton date=
netstat -anp | grep “:2111”
ps -ef | grep dsa
find -name “Panorama”
su – riverbed 
#password=
cd /opt/Panorama/hedzup/mn/bin
./dsactl stop
sed -i 's/Attribute name="ManageableByRemoteAgent" value="true"/Attribute name="ManageableByRemoteAgent" value="false"/gI' /opt/Panorama/hedzup/mn/data/dsa.ml
./dsactl start
netstat -anp | grep “:2111”
 



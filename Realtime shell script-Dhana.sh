########################################shell script###########################
##Unix-like systems have the best command-line tools.
1.Each command performs a simple function to make our work easier. 
2.These simple functions can be combined with other commands to solve complex problems. 
3.Combining simple commands is an art; you will get better at it as you practice and gain experience. 
################creating the of file with previous date and time############# 
#!/bin/bash
#Author=
#Purpose=
#Creation date=
#Modificaton date=
# creating the of file with previous date and time 
touch -d "Mon 5 June 2021 12:23:15" Oldfile{1..5}.txt

################################find the 90 days old files#####################
#find /var/log -mtime +90 -exec ls -l {} \;
# rename the old files
$ find /opt/scripts -mtime +90 -exec mv {} {}.new \;

######Deleting the old 90 days files 
$ find /opt/scripts -mtime +90 -exec rm {} \;

###############archive the file , compress and move to the remote host or remote destination#####################
tar -cvf /opt/backup.tar /var/log
gzip /opt/backup.tar
find /opt/backup.tar.gz -mtime -1 -type f -print &> /dev/null
if [ $? -eq 0]
then 
echo "backup sucess created"
echo " archive also created"
scp /opt/backup.tar.gz root@172.168.10.44:/data/backupstorage
else 
echo "backup failed"
fi

##################To known the login user details###################################
echo "please enter day (e.g Mon)"
read day
echo "please enter Month (e.g jun)"
read Month
echo "please enter date (e.g 17)"
read date
echo
last | grep "$day $month $date"
last

# To check the current date
echo "Current time is $(date)"

###################find the file with .txt and move to .html#############
filename=`find /tmp/scripts/ -name "*.txt" | cut -d "." -f1`
for i in $filename
do
mv $i.txt $i.html
done

##To check the size of file in directory
dir=/tmp
###for file in $dir/* ;
do 
echo "file $file is $(stat --printf='%s' $file) Bytes."
done
du -sh /tmp

###########################To check the service status###################################
#!/bin/bash

read -p "Enter start,stop,status,enabled,and Disabled  to perform action on  services: " action
read -p "Enter the Service name=" Service_name
Systemtcl=$(systemctl ${action} ${Service_name})
if [ "${action}" == "start" ]
then
echo "${action} ${Service_name}...."
echo"$Systemtcl" # systemctl ${action} $(Service_name)
echo "${action} ${Service_name} is start"
fi

if [ "${action}" == "stop" ]
then
  echo "${action} ${Service_name}..........."
echo "$Systemtcl" # systemctl ${action} $(Service_name)
echo -e  "this show the status\033[96m $status\033[0m"
echo "${action} ${Service_name} stop status showing"
fi


if [ "${action}" == "status" ]
then
 echo "stopping ${Service_name}..."
 echo"$Systemtcl" # systemctl ${action} $(Service_name)
 echo "${action} ${Service_name}"
fi
                #or
#!/bin/bash
read -p "Enter start,stop,status,enabled,and Disabled  to perform action on  services: " action
read -p "Enter the Service name=" Service_name
Systemtcl=$(systemctl ${action} ${Service_name})
#Assume variable a holds 10 and variable b holds 20 then −
# -o	This is logical OR. If one of the operands is true, then the condition becomes true.	[ $a -lt 20 -o $b -gt 100 ] is true.
if [ "${action}" == "start" -o  "${action}" == "stop" -o  "${action}" == "status" -o  "${action}" == "enabled" -o  "${action}" == "disabled" ]
then
echo "${action} ${Service_name}...."
echo"$Systemtcl" # systemctl ${action} $(Service_name)
echo -e  "this show the status\033[96m $status\033[0m"
echo "${action} of  ${Service_name} .... "
fi

#######################Remote Server connectiviy checking#########################################
host=/opt/host_ipaddress #( hostip address in file)
for ip in $(cat $host)
do  
   ping -c1 $ip &> /dev/null
   if [ $? -eq 0 ]
   then 
   echo "$ip is pinging"
   else
   echo "$ip is not working"
   fi
done 
#######################################
#!/bin/bash
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

#######################################
#!/bin/bash
SCRIPT=""top -b -o +%MEM | head -n 30 > /var/cpu-loadaverage.log
HOSTS=("192.168.1.121" "192.168.1.122" "192.168.1.123")
USERNAMES=("username1" "username2" "username3")
PASSWORDS=("password1" "password2" "password3")
for i in ${!HOSTS[*]} ; do
     echo ${HOSTS[i]}
     SCR=${SCRIPT/PASSWORD/${PASSWORDS[i]}}
     sshpass -p ${PASSWORDS[i]} ssh -l ${USERNAMES[i]} ${HOSTS[i]} "${SCR}"
done

######################

#!/bin/bash
username="user"
servers=("srv-001" "srv-002" "srv-002" "srv-003");
script="pwd;"
for s in "${servers[@]}"; do
    echo "sshing ${username}@${s} to run ${script}"
    (ssh ${username}@${s} ${script})& # Run in background
done
wait # If removed, you can run some other script here

#######################Database daily log compress########################################
#refernces purpose
 #date --date="yesterday" | awk '{print $1}'
 #date | awk '{print $1}'
 #date +"%a"
 #date --date="yesterday"
 #date --date="yesterday" | awk '{print $1}'
#!/bin/bash
day=$(date +"%a")
touch postgres-$day.log
previousday=$(date --date="yesterday" | awk '{print $1}')
day=$(date +"%a")
rm -rf postgres-$previousday.log.xz
xz -vv -9 -f  postgres-$previousday.log
################################### ssl certificate###########################################
CertExpires=`openssl x509 -in /path/to/cert.pem -inform PEM -text -noout -enddate | grep "Not After" | awk ‘{print $4, $5, $7}’`
TodayPlus30=`date -ud "+30 day" | awk ‘{print $2, $3, $6}’`
if [ "$CertExpires" = "$TodayPlus30" ]
then
echo "Your SSL Cert will expire in 30 days." | mail -s "SSL Cert
Monitor" someone@example.com
fi

#######################Prechecks-before-Patch###########################################
#!/bin/bash
#host=/opt/hostipaddress #( hostip address in file)
today=$(date +"%F")
path=/var/server_precheck_patch-$today
  echo '===========================================Precheck_outputs of file system ==================================================' >>  $path
  echo
  df -Th >> $path
  echo '==============================================Precheck_outputs of logical volume===================================================== ' >> $path
  lvs >> $path
  echo '==============================================Precheck_outputs of volume group ==================================================== ' >> $path
  vgs >> $path
   echo '==============================================Precheck_outputs of volume group ==================================================== ' >> $path
  pvs >> $path
  echo '=============================================Precheck_outputs of fstab entry===================================================== ' >> $path
  cat /etc/fstab >> $path
  echo '=============================================Precheck_outputs of resolv.conf===================================================== ' >> $path
  cat /etc/resolv.conf >> $path
  echo '=============================================Precheck_outputs of hosts file===================================================== ' >> $path
  cat /etc/hosts >> $path
  echo '=============================================Precheck_outputs of routes==================================================== ' >> $path
  route -n >> $path
  echo '==============================================Precheck_outputs of netstat=================================================== ' >> $path
  netstat -rn >> $path
  echo '=============================================Precheck_outputs of ifconfig===================================================== ' >> $path
  ifconfig -a >> $path
  echo '==============================================Precheck_outputs of os release==================================================== ' >> $path
  cat /etc/os-release >> $path
  echo '==========================================================Precheck_outputs of hostnamecl ======================================== ' >> $path
  hostnamectl >> $path
  echo '================================================Precheck_outputs uname or kernel================================================== ' >> $path
  uname -a >> $path
  echo '================================================================================================================== ' >> $path

################# check file size and compress or delete or move######################
#https://www.tutorialspoint.com/unix/unix-regular-expressions.htm
size=$(du -ch /var/datastore/dhana.log  | grep total  | awk '{print $1}')
mail=dhanapal703278@gmail.com
path=/var/datastore/dhana.log
dest=/opt/data/dhana.log
if [ $size -le 70M  ]
then

sudo rm -rf $path
echo "If file is less than 70MB then delete the file"

sudo echo "subject: If file is less than 70MB then delete the file" | sendmail $mail

else
echo "If  file is greater than 70MB then copy  to romte server or another location"
sudo  cp -rf $path $dest

sudo echo "subject: IF file is greater than 70MB copy to remote sucess" | sendmail $mail
fi

##########################ifcondition-chanage-configuration###################################################
#!/bin/bash
#Author=
#Purpose=
#Creation date=
#Modificaton date=
port=$(netstat -anp  | grep :2111 )
#port=$(netstat -anp  | grep :2111 | awk '{print $4}')
ps=$(ps -ef | grep dsa )
# example taken from this ! -z "$var"
if [ ! -z "$port" -a !  -z "$ps " ]
then
echo "port  is open"
echo "proces  is  running "

echo 'su – riverbed'
#password=
cp -rvf /opt/Panorama/hedzup/mn/data/dsa.ml /home/dsa.ml.bak
cd /opt/Panorama/hedzup/mn/bin
./dsactl stop
sed -i 's/Attribute name="ManageableByRemoteAgent" value="true"/Attribute name="ManageableByRemoteAgent" value="false"/gI' /opt/Panorama/hedzup/mn/data/dsa.ml
./dsactl start
echo '&port'
else 
echo " process  is not running or port is not open "

fi

########################################change-configuration###################################################
#!/bin/bash
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

#######################Xapp files deleting ###############################
#!/bin/bash
#Author=
#Purpose=
#Creation date=
#Modificaton date=
cd /home/xapps/public_html/
#path=$(find /home/xphenoapps/public_html/ -name "*htaccess*" -type f | wc -l)
find=$(find /home/xapps/public_html/ -name "*htaccess*" -type f | wc -l)
   if [ $find -gt 2 ]
   then
   echo ".htaccess file are cerated in /home/xapps/public_html path "
   echo "First we stoping httpd Service"
   service httpd stop
    echo "deleting the files of .htaccess in /home/xapps/public_html path  "

    find  /home/apps/public_html/ -name "*htaccess*" -type f -delete
    echo "replacing the backup of  .htaccess files in (/home/xapps/public_html/"

    cd /home/sai/attrium/
    cp -rvf .htaccess /home/xapps/public_html/attrium/
    cd /home/sai/askhr/
    ls -l
    cp -rvf .htaccess /home/xapps/public_html/askhr
    service httpd start
    cd /home/xapps/public_html/


    echo "After deleting the .htaccess files the count should be 2"

   else
   echo "In /home/xapps/public_html .htaccess file are not created more than 2"
   fi
   
####################Redirection from a file to a command#############
We can read data from a file as stdin with the less-than symbol (<):
$ cmd < file
Redirecting from a text block enclosed within a script
Text can be redirected from a script into a file. To add a warning to the top of an automatically generated file, use the following code:
#!/bin/bash
cat<<EOF>log.txt
This is a generated file. Do not edit. Changes will be overwritten.
EOF
The lines that appear betweencat<<EOF>log.txt and the next EOF line will appear as the stdin data. 
#The contents of log.txt are shown here:
$ cat log.txt
 This is a generated file. Do not edit. Changes will be overwritten.


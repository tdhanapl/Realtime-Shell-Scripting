#/bin/sh
tput setf 2
######################################################################
### Objective : To get the Server related details. This will enable###
###             								                   ###
### Author    :                          						   ###
### Date      :                                    				   ###
###             us to plan for Disaster recovery.                  ###
### Author    :                           ###
### Date      :                                        ###
### Changes   : 
### Version   :                                                 ###
######################################################################

## Initialize global variables                                     ###
########################################################################
## Variables - System Administration                                 ###
########################################################################
WHICH=/usr/bin/which
IFCONFIG=`$WHICH ifconfig`
GREP=`$WHICH grep`
 HEAD=`$WHICH head`
 AWK=`$WHICH awk`
 CUT=`$WHICH cut`
 PWD=`$WHICH pwd`
 RSYNC=`$WHICH rsync`
 ECHO=`$WHICH echo`
 SSH=`$WHICH ssh`
 CAT=`$WHICH cat`
 MKDIR=`$WHICH mkdir`
 RM=`$WHICH rm`
 SSHUSER=root
 RSYNCKEY=/root/.ssh/rsynckey
 UNAME=`$WHICH uname`
 MOUNT=`$WHICH mount`
 DF=`$WHICH df`
 SNMPD=`$WHICH snmpd`
 JAVA=`$WHICH java`
 FREE=`$WHICH free`
 DMESG=`$WHICH dmesg`
 LSPCI=`$WHICH lspci`
 HOSTNAME=`$WHICH hostname`
 NETSTAT=`$WHICH netstat`
 IPTABLESSAVE=`$WHICH iptables-save`
 MIITOOL=`$WHICH mii-tool`
 PS=`$WHICH ps`
 CRONTAB=`$WHICH crontab`
 RPM=`$WHICH rpm`
 DATE=`$WHICH date`
 FIND=`$WHICH find`
 FILE=`$WHICH file`
 NTPTRACE=`$WHICH ntptrace`
 TAIL=`$WHICH tail`
 PSQL=`$WHICH psql`
 #NMAP=`$WHICH nmap`
 FDISK=`$WHICH fdisk`
 SERVICE=`$WHICH service`
 MULTIPATH=`$WHICH multipath`
PVDISPLAY=`$WHICH pvdisplay`
VGDISPLAY=`$WHICH vgdisplay`
LVDISPLAY=`$WHICH lvdisplay`
PVS=`$WHICH pvs`
VGS=`$WHICH vgs`
LVS=`$WHICH lvs`
DMIDECODE=`$WHICH dmidecode`
SAR=`$WHICH sar`

######################################################################
### Destination Directory                                          ###
######################################################################
if [ -d /tmp/ServerDetails ]; then
echo "Directroy available /var/ServerDetails"
else
mkdir /tmp/ServerDetails
chown admin:admin -R /tmp/ServerDetails
fi

chown dmin:admin -R /tmp/ServerDetails

######################################################################
### output file                                                    ###
######################################################################
IP=`/sbin/ifconfig | /bin/grep inet | /usr/bin/head -n1 | /usr/bin/awk '{print $2}' | /usr/bin/cut -d: -f2`
#IP=`$IFCONFIG | $GREP inet | $HEAD -n1 | $AWK '{print $2}' | $CUT -d: -f2`
OUTFILE=/tmp/ServerDetails/$IP-ServerDetails-`date  '+%d%b%Y'`.txt
#OUTFILE=/tmp/$IP-`date  '+%d%b%Y_%H%M%S'`.txt


### lshw execution and rsync                                        ###
#cd /usr/bin 
#./lshw-static -html > /tmp/$IP.html


#######################################################################
### Gathering server details                                        ###
#######################################################################
$ECHO "Generated on : `$DATE`" > $OUTFILE
$ECHO "################################################################" >> $OUTFILE
$ECHO "### OS, Partion & Packages                                   ###" >> $OUTFILE
$ECHO "################################################################" >> $OUTFILE
## OS Name 
$ECHO "OS Name:" >> $OUTFILE
echo "####################" >> $OUTFILE
$CAT /etc/os-release >> $OUTFILE
$ECHO >> $OUTFILE

## Kernel Version
$ECHO "Kernel version:" >> $OUTFILE
echo "####################" >> $OUTFILE
$UNAME -a >> $OUTFILE 
$ECHO >> $OUTFILE

## Grub file Details
$ECHO "GRUB FILE /boot/grub/grub.conf DETAILS:" >> $OUTFILE
echo "#########################################" >> $OUTFILE
$CAT /boot/grub/grub.conf >> $OUTFILE
$ECHO >> $OUTFILE



## Filesystem
$ECHO "Filesystem on mount:" >> $OUTFILE
echo "####################" >> $OUTFILE
$MOUNT >> $OUTFILE
$ECHO >> $OUTFILE

## Partition details
$ECHO "Partition details:" >> $OUTFILE
echo "####################" >> $OUTFILE
$DF -hT >> $OUTFILE
$ECHO >> $OUTFILE

## filesystem details
$ECHO "FSTAB /etc/fstab details:" >> $OUTFILE
echo "####################" >> $OUTFILE
$CAT /etc/fstab >> $OUTFILE
$ECHO >> $OUTFILE

## fdisk
$ECHO "FDISK Details:" >> $OUTFILE
echo "####################" >> $OUTFILE
$FDISK -l >> $OUTFILE
$ECHO >> $OUTFILE


## LVM Details
$ECHO "LVM details:" >> $OUTFILE
echo "####################" >> $OUTFILE
$ECHO "PVDISPLAY details:" >> $OUTFILE
echo "####################" >> $OUTFILE
$PVDISPLAY >> $OUTFILE
$ECHO >> $OUTFILE
echo "######### PVS ###########" >> $OUTFILE
$PVS >> $OUTFILE
$ECHO >> $OUTFILE

$ECHO "VGDISPLAY details:" >> $OUTFILE
echo "####################" >> $OUTFILE
$VGDISPLAY >> $OUTFILE
$ECHO >> $OUTFILE
echo "######### VGS ###########" >> $OUTFILE
$VGS >> $OUTFILE
$ECHO >> $OUTFILE

$ECHO "LVDISPLAY details:" >> $OUTFILE
echo "####################" >> $OUTFILE
$LVDISPLAY >> $OUTFILE
$ECHO >> $OUTFILE
echo "######### LVS ###########" >> $OUTFILE
$LVS >> $OUTFILE
$ECHO >> $OUTFILE
echo "########LVS -a -o +seg_pe_ranges --segments############" >> $OUTFILE
$LVS -a -o +seg_pe_ranges --segments >> $OUTFILE
$ECHO >> $OUTFILE

## Multipath Details
$ECHO "Multipath details:" >> $OUTFILE
echo "####################" >> $OUTFILE
#MULTIPATH=`$WHICH multipath`
STATUS1=`echo $?`
if [ $STATUS1 -eq 0 ];then
$MULTIPATH -ll >> $OUTFILE

## Multipath config file details
$ECHO "Multipath config file details:" >> $OUTFILE
echo "###############################" >> $OUTFILE
$CAT /etc/multipath.conf >> $OUTFILE
$ECHO >> $OUTFILE


else
echo "Multipath is not Available" >> $OUTFILE
fi
$ECHO >> $OUTFILE


## important package versions
$ECHO "SSH Version:" >> $OUTFILE
echo "####################" >> $OUTFILE
$SSH -V 2>> $OUTFILE
$ECHO >> $OUTFILE

$ECHO "Snmpd Version:" >> $OUTFILE
echo "####################" >> $OUTFILE
$SNMPD -v >> $OUTFILE
$ECHO >> $OUTFILE

$ECHO "Java Version:" >> $OUTFILE
echo "####################" >> $OUTFILE
$JAVA -version 2>> $OUTFILE
$ECHO >> $OUTFILE

$ECHO "################################################################" >> $OUTFILE
$ECHO "### Hardware                                                 ###" >> $OUTFILE
$ECHO "### Critical!!!: Fill the harddisk details manually             ###" >> $OUTFILE
$ECHO "################################################################" >> $OUTFILE
## Harddisk details
$ECHO "Harddisk details:" >> $OUTFILE
$ECHO "No.of HDD:  " >> $OUTFILE
$ECHO "Configured in RAID:  " >> $OUTFILE
$ECHO "################################################################" >> $OUTFILE
$ECHO >> $OUTFILE

## WWN No details
$ECHO "WWN No Details:  " >> $OUTFILE
echo "####################" >> $OUTFILE
>/tmp/wwnhostname_portno
>/tmp/wwnhostname
HOSTCOUNT=`ls  /sys/class/fc_host/ | wc -l`
ls -l /sys/class/fc_host/ | grep -v total |awk {'print $9'} > /tmp/wwnhostname
for WWN in `cat /tmp/wwnhostname`
do
$CAT /sys/class/fc_host/$WWN/port_name  >> /tmp/wwnhostname_portno
echo " " >> /tmp/wwnhostname_portno
done
echo "WWN No Details has been COMPLETED" >> /tmp/wwnhostname_portno
$CAT /tmp/wwnhostname_portno >> $OUTFILE
$ECHO >> $OUTFILE

## RAM Available
$ECHO "RAM:" >> $OUTFILE
echo "####################" >> $OUTFILE
$FREE -m | $GREP Mem: | $AWK '{print $2}' >> $OUTFILE
$ECHO >> $OUTFILE

## Processor Info
$ECHO "Processor:" >> $OUTFILE
echo "####################" >> $OUTFILE
$CAT /proc/cpuinfo >> $OUTFILE
$ECHO >> $OUTFILE

# /proc/version
$ECHO "Details of /proc/version:" >> $OUTFILE
echo "##############################" >> $OUTFILE
$CAT  /proc/version >> $OUTFILE
$ECHO >> $OUTFILE

$ECHO "################################################################" >> $OUTFILE
$ECHO "### Network                                                  ###" >> $OUTFILE
$ECHO "### Critical!!! : PAT /NAT ip details to be filled manually  ###" >> $OUTFILE
$ECHO "################################################################" >> $OUTFILE

## Hostname
$ECHO "Hostname:" >> $OUTFILE
echo "####################" >> $OUTFILE
$HOSTNAME >> $OUTFILE
$ECHO >> $OUTFILE

## IP MAC address details
$ECHO "IP-MAC details:" >> $OUTFILE
echo "####################" >> $OUTFILE
$IFCONFIG -a >> $OUTFILE
$ECHO >> $OUTFILE

## PAT / NAT IP details
$ECHO "PAT / NAT IP details:" >> $OUTFILE
$ECHO >> $OUTFILE

## Routing entries
$ECHO "Routing entries:" >> $OUTFILE
echo "####################" >> $OUTFILE
$NETSTAT -rn >> $OUTFILE
$ECHO >> $OUTFILE

$ECHO "rc.local file entries:" >> $OUTFILE
echo "####################" >> $OUTFILE
$CAT /etc/rc.local >> $OUTFILE
$ECHO >> $OUTFILE

## Firewall rules
$ECHO "Firewall rules:" >> $OUTFILE
echo "####################" >> $OUTFILE
$IPTABLESSAVE >>  /etc/iptables.conf1 >> $OUTFILE
$CAT /etc/iptables.conf1 >> $OUTFILE
$ECHO >> $OUTFILE

## Duplex setting status
$ECHO "Duplex settings status:" >> $OUTFILE
echo "####################" >> $OUTFILE
$MIITOOL  >> $OUTFILE
$ECHO >> $OUTFILE

## Ports opened with local host
$ECHO "Ports opened with local host:" >> $OUTFILE
echo "####################" >> $OUTFILE
$ECHO >> $OUTFILE
NMAP=`$WHICH nmap`
STATUS2=`echo $?`
if [ $STATUS2 -eq 0 ];then
$NMAP -sTU localhost >> $OUTFILE
else
echo "nmap command is not Available" >> $OUTFILE
fi
$ECHO >> $OUTFILE


$ECHO "################################################################" >> $OUTFILE
$ECHO "### Services & Processes details                             ###" >> $OUTFILE
$ECHO "################################################################" >> $OUTFILE

## Services listening
$ECHO "Listening services:" >> $OUTFILE
echo "####################" >> $OUTFILE
$NETSTAT -nap | $GREP -i list >> $OUTFILE
$ECHO >> $OUTFILE

## Services Established.
$ECHO "Established services:" >> $OUTFILE
echo "####################" >> $OUTFILE
$NETSTAT -nap | $GREP -i est >> $OUTFILE
$ECHO >> $OUTFILE

## UDP services.
$ECHO "UDP:" >> $OUTFILE
echo "####################" >> $OUTFILE
$NETSTAT -nap | $GREP -i udp >> $OUTFILE
$ECHO >> $OUTFILE

## processes currently running
$ECHO "Processes currently running:" >> $OUTFILE
echo "#############################" >> $OUTFILE
$PS -efwww >> $OUTFILE
$ECHO >> $OUTFILE

$ECHO "################################################################" >> $OUTFILE
$ECHO "### Cron entries                                             ###" >> $OUTFILE
$ECHO "################################################################" >> $OUTFILE

## cron entries
$ECHO "Cron entries:" >> $OUTFILE
echo "####################" >> $OUTFILE
#$CRONTAB -l >> $OUTFILE
#$ECHO >> $OUTFILE
>/tmp/cronusers.txt
>/tmp/cronjob.txt
ls -l /var/spool/cron | grep -v total | awk {'print $9'} > /tmp/cronusers.txt

echo " CRON JOB FILES STARTED" >> /tmp/cronjob.txt
for USERS in `cat /tmp/cronusers.txt`
do
echo " CRON JOB FOR USER FILE /var/spool/cron/$USERS" >> /tmp/cronjob.txt
echo "######################" >> /tmp/cronjob.txt
cat /var/spool/cron/$USERS >> /tmp/cronjob.txt
echo " " >> /tmp/cronjob.txt
echo " " >> /tmp/cronjob.txt
done
echo " CRON JOB FILES COMPLETED" >> /tmp/cronjob.txt

$CAT /tmp/cronjob.txt >> $OUTFILE
$ECHO >> $OUTFILE
$ECHO >> $OUTFILE


$ECHO "################################################################" >> $OUTFILE
$ECHO "### Configuration files                                      ###" >> $OUTFILE
$ECHO "################################################################" >> $OUTFILE

## /etc/hosts
$ECHO "Details of /etc/hosts:" >> $OUTFILE
echo "########################" >> $OUTFILE
$CAT /etc/hosts >> $OUTFILE
$ECHO >> $OUTFILE

## /etc/hosts.allow
$ECHO "Details of /etc/hosts.allow:" >> $OUTFILE
echo "#############################" >> $OUTFILE
$CAT /etc/hosts.allow >> $OUTFILE
$ECHO >> $OUTFILE

## /etc/hosts.deny
$ECHO "Details of /etc/hosts.deny:" >> $OUTFILE
echo "############################" >> $OUTFILE
$CAT /etc/hosts.deny >> $OUTFILE
$ECHO >> $OUTFILE

## /etc/resolv.conf
$ECHO "Details of /etc/resolv.conf:" >> $OUTFILE
echo "##############################" >> $OUTFILE
$CAT /etc/resolv.conf >> $OUTFILE
$ECHO >> $OUTFILE


## Mail relay server
$ECHO "Details ofMail relay server:" >> $OUTFILE
echo "#############################" >> $OUTFILE
$CAT /etc/sendmail.cf | $GREP -i "DS" >> $OUTFILE

if [ ! -f /etc/sendmail.cf ] ; then
       # echo "Available /etc/sendmail.cf " >> $OUTFILE
	if [ ! -f /etc/mail/sendmail.cf ] ; then
	echo "Available  /etc/mail/sendmail.cf  " >> $OUTFILE
	echo "sendmail.cf conf file is not available " >> $OUTFILE
	else
	$CAT /etc/mail/sendmail.cf  | $GREP "DS" >> $OUTFILE
	fi
fi
$ECHO >> $OUTFILE


## /etc/inittab
$ECHO "Details of /etc/inittab:" >> $OUTFILE
echo "##########################" >> $OUTFILE
$CAT /etc/inittab >> $OUTFILE
$ECHO >> $OUTFILE

## /etc/sysconfig/authconfig
$ECHO "Details of /etc/sysconfig/authconfig:" >> $OUTFILE
echo "#######################################" >> $OUTFILE
$CAT /etc/sysconfig/authconfig >> $OUTFILE
$ECHO >> $OUTFILE

## /etc/nsswitch.conf
$ECHO "Details of /etc/nsswitch.conf:" >> $OUTFILE
echo "###############################" >> $OUTFILE
$CAT /etc/nsswitch.conf >> $OUTFILE
$ECHO >> $OUTFILE

## /etc/pam.d/system-auth-ac
$ECHO "Details of /etc/pam.d/system-auth-ac:" >> $OUTFILE
echo "#######################################" >> $OUTFILE
$CAT /etc/pam.d/system-auth-ac >> $OUTFILE
$ECHO >> $OUTFILE

## /etc/passwd
$ECHO "Details of /etc/passwd:" >> $OUTFILE
echo "#########################" >> $OUTFILE
$CAT /etc/passwd >> $OUTFILE
$ECHO >> $OUTFILE

## /etc/group 
$ECHO "Details of /etc/group:" >> $OUTFILE
echo "########################" >> $OUTFILE
$CAT /etc/group >> $OUTFILE
$ECHO >> $OUTFILE


## /root/.bash_profile
$ECHO "Details of /root/.bash_profile:" >> $OUTFILE
echo "####################" >> $OUTFILE
$CAT /root/.bash_profile >> $OUTFILE
$ECHO >> $OUTFILE


## /etc/bash_profile
$ECHO "Details of /etc/profile:" >> $OUTFILE
echo "####################" >> $OUTFILE
$CAT /etc/profile >> $OUTFILE
$ECHO >> $OUTFILE

## Service details
$ECHO "SERVICES DETAILS:" >> $OUTFILE
echo "####################" >> $OUTFILE
$SERVICE --status-all >> $OUTFILE
$ECHO >> $OUTFILE


## /etc/ntp.conf
$ECHO "Details of /etc/ntp.conf:" >> $OUTFILE
echo "####################" >> $OUTFILE
$CAT /etc/ntp.conf >> $OUTFILE
$ECHO >> $OUTFILE

## /etc/snmpd.conf
$ECHO "Details of /etc/snmp/snmpd.conf:" >> $OUTFILE
echo "####################" >> $OUTFILE
$CAT /etc/snmp/snmpd.conf >> $OUTFILE
$ECHO >> $OUTFILE

## /etc/ld.so.conf
$ECHO "Details of /etc/ld.so.conf:" >> $OUTFILE
echo "####################" >> $OUTFILE
$CAT /etc/ld.so.conf >> $OUTFILE

$ECHO "################################################################" >> $OUTFILE
$ECHO "### others                                                   ###" >> $OUTFILE
$ECHO "################################################################" >> $OUTFILE


## dmidecode details
$ECHO "dmidecode:" >> $OUTFILE
echo "####################" >> $OUTFILE
$DMIDECODE >> $OUTFILE
$ECHO >> $OUTFILE
$ECHO >> $OUTFILE


## rpm packages installed
$ECHO "rpm packages installed:" >> $OUTFILE
echo "####################" >> $OUTFILE
$RPM -qa >> $OUTFILE
$ECHO >> $OUTFILE



## To identify whether CD-ROM /DVD-ROM is available, NIC card driver, HDD Driver etc., and for other related information.
$ECHO "Dmesg Contents:" >> $OUTFILE
echo "####################" >> $OUTFILE
$DMESG  >> $OUTFILE
$ECHO >> $OUTFILE

## Driver details
$ECHO "Driver details:" >> $OUTFILE
echo "####################" >> $OUTFILE
$LSPCI >> $OUTFILE
$ECHO >> $OUTFILE

## LOAD details with SAR -A details
$ECHO "SAR -A:" >> $OUTFILE
echo "####################" >> $OUTFILE
$SAR -A >> $OUTFILE
$ECHO >> $OUTFILE
$ECHO >> $OUTFILE

$ECHO "### Critical!!!: Fill the harddisk details manually          ###" 
$ECHO "### Critical!!! : PAT /NAT ip details to be filled manually  ###"
$ECHO "### Critical!!! : Please note the errors on your screen and identify whether related details are populated. If not fill them manually  ###"
$ECHO "### Output has been written in file /tmp/ServerDetails/$IP-ServerDetails-`date  '+%d%b%Y'`.txt  ###" 
#$ECHO "### Output has been written in file /tmp/$IP-`date  '+%d%b%Y'`.txt  ###" 

##### Remove old files
find /tmp/ServerDetails -name "*ServerDetails-*.txt" -mtime +6 -exec rm -f {} \;
chown admin:admin -R /tmp/ServerDetails

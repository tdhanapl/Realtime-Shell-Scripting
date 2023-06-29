#############################Prechecks-before-Patch###########################################
#!/bin/bash
######################################################################
### Objective : To get the Server  related basic  details          ###
### Author    : T Dhanapal                                         ###
### Date      :                                                    ###
### Changes   :                                                    ###  
### Version   :                                                    ###
######################################################################
######################################################################
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
  echo '==============================================Precheck_outputs of physical volume ==================================================== ' >> $path
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
  netstat -nutlp >> $path
  echo '=============================================Precheck_outputs of ifconfig===================================================== ' >> $path
  ifconfig -a >> $path
  echo '==============================================Precheck_outputs of os release==================================================== ' >> $path
  cat /etc/os-release >> $path
  echo '==========================================================Precheck_outputs of hostnamecl ======================================== ' >> $path
  hostnamectl >> $path
  echo '================================================Precheck_outputs uname or kernel================================================== ' >> $path
  uname -a >> $path
  echo '================================================================================================================== ' >> $path
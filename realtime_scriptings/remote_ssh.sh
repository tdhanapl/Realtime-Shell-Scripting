#!/bin/bash
#note:
# for the run shell required sudo permission for we need give in sudoers file NOPASSWORD:
sshpass -p ikt@900 ssh -o StrictHostKeyChecking=No ec2-user@192.168.10.5  "date; ls; cat  patch_precheck.sh ; sudo ./patch_precheck.sh ; cat /var/server_precheck_patch-2022-10-10"

 
##this using passwordless authenication here password also not required 
 ssh -o StrictHostKeyChecking=No dhanapal.ikt@10.2.247.5  "date; ls ; sudo ./patch_precheck.sh ; cat /var/server_precheck_patch-2022-10-10"

# for servername in 'cat /home/serverlist'
# do
# #ssh dhanapal@$servername sh /scripts/diskspace.sh
# ssh root@ec2-15-206-67-34.ap-south-1.compute.amazonaws.com sh /home/ec2-user/server_reachable_check.sh 
# done

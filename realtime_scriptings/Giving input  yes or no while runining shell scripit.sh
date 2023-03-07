#!/bin/bash
for i in `cat /home/dhanapal.ikt/stopping-services/kube_stopping_service_oder_ip`; do ssh $i   "hostname; yes Y | sudo /opt/kubernetes/bin/kube-stop.sh; sudo systemctl status nfs"; done
for i in `cat /home/dhanapal.ikt/stopping-services/nfs_stopping_service_oder_ip`; do ssh $i  "hostname; sudo systemctl stop nfs;  systemctl status nfs"; done

#note:
#user need nopassword in sudoers file for running shell in different servers.
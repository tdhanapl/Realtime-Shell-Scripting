#!/bin/bash
for i in `cat /home/dhanapal.ikt/kube_service_oder`; do ssh $i   "hostname; sudo /opt/kubernetes/bin/kube-status.sh; sudo systemctl status nfs"; done
#for i in `cat /home/dhanapal.ikt/nfs_stop_service_odrer`; do ssh $i  "hostname; sudo systemctl status nfs"; done
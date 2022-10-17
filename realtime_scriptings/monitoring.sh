#!/bin/bash
tput setf 2
[ ! -d /var/log/proc_mon ] && mkdir -p /var/log/proc_mon

echo "`date`" >> /var/log/proc_mon/proc_mon_`date +%d-%b-%Y`

echo "TOP CUP Utilization" >> /var/log/proc_mon/proc_mon_`date +%d-%b-%Y`
echo "^^^^^^^^^^^^^^^^^^^" >> /var/log/proc_mon/proc_mon_`date +%d-%b-%Y`
/usr/bin/top -b -n1 -o %CPU | grep -v top$ | head -n 20 >> /var/log/proc_mon/proc_mon_`date +%d-%b-%Y`

echo "TOP Memory Utilization" >> /var/log/proc_mon/proc_mon_`date +%d-%b-%Y`
echo "^^^^^^^^^^^^^^^^^^^^^^" >> /var/log/proc_mon/proc_mon_`date +%d-%b-%Y`
/usr/bin/top -b -n1 -o %MEM | grep -v top$ | head -n 30 >> /var/log/proc_mon/proc_mon_`date +%d-%b-%Y`

echo "Dead state process" >> /var/log/proc_mon/proc_mon_`date +%d-%b-%Y`
echo "^^^^^^^^^^^^^^^^^^" >> /var/log/proc_mon/proc_mon_`date +%d-%b-%Y`
ps aux | awk '{if ($8 == "D") print $0;}' >> /var/log/proc_mon/proc_mon_`date +%d-%b-%Y`

echo "=======================================================================" >> /var/log/proc_mon/proc_mon_`date +%d-%b-%Y`

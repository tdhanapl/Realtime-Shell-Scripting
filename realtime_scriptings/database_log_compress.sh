######################################Database daily log compress########################################
#refernces purpose
 #date --date="yesterday" | awk '{print $1}'
 #date | awk '{print $1}'
 #date +"%a"
 #date --date="yesterday"
 #date --date="yesterday" | awk '{print $1}'
#!/bin/bash
tput setf 2
day=$(date +"%a")
touch postgres-$day.log
previousday=$(date --date="yesterday" | awk '{print $1}')
day=$(date +"%a")
rm -rf postgres-$previousday.log.xz
xz -vv -9 -f  postgres-$previousday.log
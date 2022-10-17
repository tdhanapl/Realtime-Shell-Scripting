#######Xphenoapp files deleting corrupted files#####
#!/bin/bash
tput setf 2
#Author=
#Purpose=
#Creation date=
#Modificaton date=
cd /home/xphenoapps/public_html/
#path=$(find /home/xphenoapps/public_html/ -name "*htaccess*" -type f | wc -l)
find=$(find /home/xphenoapps/public_html/ -name "*htaccess*" -type f | wc -l)
   if [ $find -gt 2 ]
   then
   echo ".htaccess file are cerated in /home/xphenoapps/public_html path "
   echo "First we stoping httpd Service"
   service httpd stop
    echo "deleting the files of .htaccess in /home/xphenoapps/public_html path  "

    find  /home/xphenoapps/public_html/ -name "*htaccess*" -type f -delete
    echo "replacing the backup of  .htaccess files in (/home/xphenoapps/public_html/"

    cd /home/sai.ikt/attrium/
    cp -rvf .htaccess /home/xphenoapps/public_html/attrium/
    cd /home/sai.ikt/askhr/
    ls -l
    cp -rvf .htaccess /home/xphenoapps/public_html/askhr
    service httpd start
    cd /home/xphenoapps/public_html/


    echo "After deleting the .htaccess files the count should be 2"

   else
   echo "In /home/xphenoapps/public_html .htaccess file are not created more than 2"
   fi
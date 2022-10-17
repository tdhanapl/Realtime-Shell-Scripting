################################ check file size and compress or delete or move######################
#https://www.tutorialspoint.com/unix/unix-regular-expressions.htm
#!/bin/bash
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
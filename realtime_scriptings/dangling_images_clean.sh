/var/ > 85 
robin version 
5.4.11  
if folder kvm and 
docker load -i <>

#!/bin/bash
hostname=$(hostname)
varspace=$(du -sh /var | awk '{print $1}')
robin version=$(robin version)
docker_diskusage=$(docker system df )
dangling_images_clean=docker prune -a 
if [ $varspace > "85" ] ; then
	echo "The current space of  /var is  $varspace"
	echo "For checking the dangling images in cluster"
	echo "$docker_diskusage"
	echo "$dangling_images_clean"
else
echo "The current space of  /var is lesser than $varspace"
fi
#!/bin/bash
hostname=$(hostname)
varspace=$(du -sh /var | awk '{print $1}')
robin version=$(robin version)
docker_diskusage=$(docker system df )
dangling_images_clean=docker prune -a 
if [ $varspace > "85" ] ; then
	echo "The current space of  /var is  $varspace"
	echo "For checking the dangling images in cluster"
	echo "$docker_diskusage"
	echo "$dangling_images_clean"
else
echo "The current space of  /var is lesser than $varspace"
fi

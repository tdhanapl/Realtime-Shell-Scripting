###install using binary package 
#!/bin/bash
useradd postgres
echo
cd /usr/bin/
echo
echo
wget https://ftp.postgresql.org/pub/source/v14.5/postgresql-14.5.tar.gz
tar -xvf postgresql-14.5.tar.gz
echo
cd postgresql-14.5
echo 
yum install gcc -y
echo
./configure --without-readline --without-zlib
echo
make && make install
echo
cd /contrib
echo
make && make install
echo 
mkdir -p /var/lib/pgsql/14/data 
echo 
chown postgres:postgres /var/lib/pgsql/14/data
echo 
chmod 750 /var/lib/pgsql/14/data
su - postgres -c '/usr/local/pgsql/bin/initdb -D /var/lib/pgsql/14/data/; /usr/local/pgsql/bin/pg_ctl -D /var/lib/pgsql/14/data/  start; /usr/local/pgsql/bin/psql'
 
 ## install using rpm package
 sudo yum install -y https://download.postgresql.org/pub/repos/yum/reporpms/EL-7-x86_64/pgdg-redhat-repo-latest.noarch.rpm
sudo yum install -y postgresql14-server
sudo /usr/pgsql-14/bin/postgresql-14-setup initdb
sudo systemctl enable postgresql-14
sudo systemctl start postgresql-14
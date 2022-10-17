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
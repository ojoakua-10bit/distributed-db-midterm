#!/bin/bash

wget -q https://repo.percona.com/apt/percona-release_latest.$(lsb_release -sc)_all.deb
sudo dpkg -i percona-release_latest.$(lsb_release -sc)_all.deb
sudo percona-release setup ps57
sudo apt-get upgrade -y
sudo apt-get remove apparmor -y
sudo apt-get install percona-xtradb-cluster-server-5.7 -y

sudo systemctl stop mysql
cat > wsrep.cnf << EOF
[mysqld]
wsrep_provider=/usr/lib/libgalera_smm.so

wsrep_cluster_name=pxc-cluster
wsrep_cluster_address=gcomm://192.168.16.71,192.168.16.72,192.168.16.73

wsrep_node_name=node2
wsrep_node_address=192.168.16.72

wsrep_sst_method=xtrabackup-v2
wsrep_sst_auth=sstuser:passwd

pxc_strict_mode=ENFORCING

binlog_format=ROW
default_storage_engine=InnoDB
innodb_autoinc_lock_mode=2
EOF
sudo mv -v wsrep.cnf /etc/mysql/percona-xtradb-cluster.conf.d/wsrep.cnf


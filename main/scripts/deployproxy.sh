#!/bin/bash

wget -q https://repo.percona.com/apt/percona-release_latest.$(lsb_release -sc)_all.deb
sudo dpkg -i percona-release_latest.$(lsb_release -sc)_all.deb
sudo percona-release setup ps57
sudo apt-get upgrade -y
sudo apt-get remove apparmor -y
sudo apt-get install proxysql2 percona-xtradb-cluster-client-5.7 -y


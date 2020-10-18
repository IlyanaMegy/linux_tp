#!/bin/bash

yum update
yum upgrade

systemctl start firewalld
firewall-cmd --zone=public --permanent --add-port=80/tcp
firewall-cmd --zone=public --permanent --add-port=443/tcp
firewall-cmd --permanent --add-service=nfs
firewall-cmd --complete-reload

# install also netstat
yum install net-tools -y

#install wget
sudo yum install -y wget


#install nfs
yum install nfs-utils nfs-utils-lib

#if IP6 disable
dracut -f -v

chkconfig nfs on
service rpcbind start
service nfs start
service nfslock start
service rpcbind start

# desactive SElinux de façon temporaire
setenforce 0

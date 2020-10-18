#!/bin/bash

#partage du fichier /backup/nfs avec la machine nfsserv
mkdir -p home/vagrant/backup/nfs
mount -t nfs4 nfsserv:/home/vagrant/$HOSTNAME home/vagrant/backup/nfs

#montage à chaque demarrage
echo "nfsserv:/home/vagrant/$HOSTNAME home/vagrant/backup/nfs   nfs    soft,timeo=5,intr,rsize=8192,wsize=8192  0  0" >> /etc/fstab
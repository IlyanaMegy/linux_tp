#!/bin/bash

#create backup destination files
mkdir /home/vagrant/giteaserv /home/vagrant/nginxserv /home/vagrant/bddserv

#partage des dossiers backup avec les machines proriétaires des backup
echo "/home/vagrant/nginxserv 192.168.4.11(rw,sync,no_root_squash)" >> /etc/exports
echo "/home/vagrant/giteaserv 192.168.4.12(rw,sync,no_root_squash)" >> /etc/exports
echo "/home/vagrant/bddserv   192.168.4.13(rw,sync,no_root_squash)" >> /etc/exports
exportfs -a
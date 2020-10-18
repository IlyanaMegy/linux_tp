#!/bin/bash
path=/etc/gitea
element=gitea

# copier des éléments vers 
sudo cp -f $path home/vagrant/backup/nfs/backup_$element

#archive et compresse le dossier backup
tar -czf home/vagrant/backup/nfs/backup_$element.tar.gz --absolute-names home/vagrant/backup/nfs/backup_$element
rm -rf home/vagrant/backup/nfs/backup_$element
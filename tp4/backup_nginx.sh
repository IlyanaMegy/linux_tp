#!/bin/bash
path=/etc/nginx
element=nginx.conf

# copier des éléments vers le dossier backup
sudo cp -f $path/$element home/vagrant/backup/nfs/backup_$element

#archive et compresse le dossier backup
tar -czf home/vagrant/backup/nfs/backup_$element.tar.gz --absolute-names home/vagrant/backup/nfs/backup_$element
rm -rf home/vagrant/backup/nfs/backup_$element
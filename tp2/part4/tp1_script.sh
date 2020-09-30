#!/bin/bash

#on crée l'utilisateur web qui sera propriétaire des sites 1 et 2
useradd --no-create-home --system web

echo '192.168.2.22  node2' >> /etc/hosts


#on crée les sites 1 et 2 avec leur fichier index.html respectif
mkdir /srv/site1
chown web /srv/site1
chmod 744 /srv/site1
echo "Tu es sur le site 1 !" >> /srv/site1/index.html

mkdir /srv/site2
chown web /srv/site2
chmod 744 /srv/site2
echo "Tu es sur le site 2 !" >> /srv/site2/index.html

#on créé les certificats https et on les déplace dans le dossier /etc/nginx
openssl req -new -newkey rsa:2048 -days 365 -nodes -x509 -keyout node1.site1.key -out node1.site1.crt -subj "/CN=node1.site1"
openssl req -new -newkey rsa:2048 -days 365 -nodes -x509 -keyout node1.site2.key -out node1.site2.crt -subj "/CN=node1.site1"
mv node1.site1.key node1.site1.crt node1.site2.key node1.site2.crt /etc/nginx

#nginx.conf importé depuis mon PC Windows va overwrite le fichier par défaut /etc/ngnix/nginx.conf
cp -f /home/vagrant/nginx.conf /etc/nginx/nginx.conf

echo "127.0.2.1 node1.site1 node1.site2" >> /etc/hosts
systemctl start nginx

#!/bin/bash

#install nginx
yum install -y epel-release
yum install -y nginx

#on crée l'utilisateur web qui sera propriétaire des sites 1 et 2
useradd --no-create-home --system web


#on crée les sites 1 et 2 avec leur fichier index.html respectif
mkdir /srv/site1
chown web /srv/site1
chmod 744 /srv/site1
echo "Tu es sur le site 1" >> /srv/site1/index.html

mkdir /srv/site2
chown web /srv/site2
chmod 744 /srv/site2
echo "Tu es sur le site 2" >> /srv/site2/index.html

#on créé les certificats https et on les déplace dans le dossier /etc/nginx
openssl req -new -newkey rsa:2048 -days 365 -nodes -x509 -keyout nginxserv.site1.key -out nginxserv.site1.crt -subj "/CN=nginxserv.site1"
openssl req -new -newkey rsa:2048 -days 365 -nodes -x509 -keyout nginxserv.site2.key -out nginxserv.site2.crt -subj "/CN=nginxserv.site1"
mv nginxserv.site1.key nginxserv.site1.crt nginxserv.site2.key nginxserv.site2.crt /etc/nginx

#nginx.conf importé depuis mon PC Windows va overwrite le fichier par défaut /etc/ngnix/nginx.conf
cp -f /home/vagrant/nginx.conf /etc/nginx/nginx.conf

echo "127.0.2.1 nginxserv.site1 nginxserv.site2" >> /etc/
systemctl daemon-reload
systemctl start nginx

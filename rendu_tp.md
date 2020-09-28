## TP1 : Déploiement classique

**0. Prérequis**

🌞 *Setup de deux machines CentOS7 configurée de façon basique.*

1/ un disque de 5Go ;
- une partition de 2Go sera montée sur `/srv/site1`
- une partition de 3Go sera montée sur `/srv/site2`
```
NAME            MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
sda               8:0    0    8G  0 disk
├─sda1            8:1    0    1G  0 part /boot
└─sda2            8:2    0    7G  0 part
  ├─centos-root 253:0    0  6,2G  0 lvm  /
  └─centos-swap 253:1    0  820M  0 lvm  [SWAP]
sdb               8:16   0    6G  0 disk
├─data-data1    253:2    0    2G  0 lvm  /srv/site1
└─data-data2    253:3    0    3G  0 lvm  /srv/site2
sr0              11:0    1 1024M  0 rom
sr1              11:1    1  942M  0 rom
```

- montées automatiquement au démarrage (fichier `/etc/fstab`)
```
$ cat /etc/fstab

/dev/data/data1 /srv/site1      ext4    defaults        0 0                        /dev/data/data2 /srv/site2      ext4    defaults        0 0                        
```  

🌞 *un accès internet*
````
$ ip a
2: enp0s3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP group default qlen 1000
    link/ether 08:00:27:94:bd:38 brd ff:ff:ff:ff:ff:ff
    inet 10.0.2.15/24 brd 10.0.2.255 scope global noprefixroute dynamic enp0s3
       valid_lft 82725sec preferred_lft 82725sec
    inet6 fe80::d9cf:140:1661:e99/64 scope link noprefixroute
       valid_lft forever preferred_lft forever
3: enp0s8: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP group default qlen 1000
    link/ether 08:00:27:5d:0d:5f brd ff:ff:ff:ff:ff:ff
    inet 192.168.1.11/24 brd 192.168.1.255 scope global noprefixroute enp0s8
       valid_lft forever preferred_lft forever
    inet6 fe80::a00:27ff:fe5d:d5f/64 scope link
       valid_lft forever preferred_lft forever
````   

````
[ilyana@node1 ~]$ route -n
Table de routage IP du noyau
Destination     Passerelle      Genmask         Indic Metric Ref    Use Iface
0.0.0.0         10.0.2.2        0.0.0.0         UG    100    0        0 enp0s3
10.0.2.0        0.0.0.0         255.255.255.0   U     100    0        0 enp0s3
192.168.1.0     0.0.0.0         255.255.255.0   U     101    0        0 enp0s8              
````


🌞 *un accès à un réseau local*
- node1 :
````
$ ip a
3: enp0s8: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP group default qlen 1000
    link/ether 08:00:27:5d:0d:5f brd ff:ff:ff:ff:ff:ff
    inet 192.168.1.11/24 brd 192.168.1.255 scope global noprefixroute enp0s8
       valid_lft forever preferred_lft forever
    inet6 fe80::a00:27ff:fe5d:d5f/64 scope link
       valid_lft forever preferred_lft forever
````   

- node2 :
 ````
$ ip a
3: enp0s8: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP group default qlen 1000
    link/ether 08:00:27:5d:0d:5f brd ff:ff:ff:ff:ff:ff
    inet 192.168.1.12/24 brd 192.168.1.255 scope global noprefixroute enp0s8
       valid_lft forever preferred_lft forever
    inet6 fe80::a00:27ff:fe5d:d5f/64 scope link
       valid_lft forever preferred_lft forever
````   

- node2 ping node1 :
```
[ilyana@node1 ~]$ ping node2
PING node2 (192.168.1.12) 56(84) bytes of data.
64 bytes from node2 (192.168.1.12): icmp_seq=1 ttl=64 time=0.773 ms
64 bytes from node2 (192.168.1.12): icmp_seq=2 ttl=64 time=0.672 ms
64 bytes from node2 (192.168.1.12): icmp_seq=3 ttl=64 time=0.775 ms
```

🌞 *un utilisateur administrateur est créé sur les deux machines*
```
[ilyana@node1 ~]$ sudo ls -al /root
total 24
dr-xr-x---.  2 root root  114 23 sept. 12:22 .
dr-xr-xr-x. 17 root root  224 23 sept. 12:21 ..
-rw-------.  1 root root 1433 23 sept. 12:22 anaconda-ks.cfg
-rw-r--r--.  1 root root   18 29 déc.   2013 .bash_logout
-rw-r--r--.  1 root root  176 29 déc.   2013 .bash_profile
-rw-r--r--.  1 root root  176 29 déc.   2013 .bashrc
-rw-r--r--.  1 root root  100 29 déc.   2013 .cshrc
-rw-r--r--.  1 root root  129 29 déc.   2013 .tcshrc
```

---
**I. Setup serveur Web**

🌞 *Installer le serveur web NGINX sur `node1.tp1.b2`*
```
[ilyana@node1 ~]$ sudo systemctl status nginx
● nginx.service - The nginx HTTP and reverse proxy server
   Loaded: loaded (/usr/lib/systemd/system/nginx.service; disabled; vendor preset: disabled)
   Active: active (running) since jeu. 2020-09-24 11:05:43 CEST; 10s ago
```

🌞 *Prouver que la machine `node2` peut joindre les deux sites web.*
```
[ilyana@node2 ~]$ curl -L node1
<p>site 2</p>
```

---
**II. Script de sauvegarde**


🌞 *Ecrire un script*

```
[backup@node1 ~]$ cat tp1_backup.sh
#!/bin/bash

site=$1
mkdir "backup_$site-$(date +"%d.%m.%Y")_$(date +%H)"

backup_folder="backup_$site-$(date +"%d.%m.%Y")_$(date +%H)"

# copier tous les fichiers et dossiers vers $backup_folder
for element in $( ls /srv/$site)
do
        cp /srv/$site/$element /home/backup/$backup_folder
done

#archive et compresse le dossier backup
tar -czf $backup_folder.tar.gz /home/backup/$backup_folder
rm -rf $backup_folder

# variable pour supprimer de la 7e sauvegarde s'il y en a une
# la plus ancienne sauvegarde a été effectuée il y a 7h
current_hour=$(date +%H)
potential_oldest=$(($current_hour-7))

if [ "$potential_oldest" -le 0 ]
then
        potential_oldest=$((24 + $potential_oldest))
fi

# check folders in web_backup
num_file=0
for element in $(ls /home/backup/web_backup)
do
        num_file=$((num_file + 1))
done

if [ "$num_file" -eq 7 ]
then
        # supprimer la sauvegarde la plus ancienne du dossier web_backup
        rm /home/backup/web_backup/"backup_$site-$(date +"%d.%m.%Y")_$potential_oldest.tar.gz"
fi
mv /home/backup/$backup_folder.tar.gz /home/backup/web_backup
```
j'ai préféré prendre en argument uniquement le site à sauvegarder 

    $ ./tp_backup.sh site1

ou 

    $ ./tp_backup.sh site2

🌞 *Utiliser la `crontab` pour que le script s'exécute automatiquement toutes les heures.*

Pour la sauvegarde toutes les heures avec crontab j'ai créé deux fichiers save_site1.sh et save_site2.sh
```
[backup@node1 ~]$ cat save_site1.sh
#!/bin/sh

./tp1_backup.sh site1

[backup@node1 ~]$ cat save_site2.sh
#!/bin/bash

./tp1_backup.sh site2
```
```
[backup@node1 ~]$ crontab -e

@hourly backup /home/backup/save_site2.sh
@hourly backup /home/backup/save_site1.sh
```
---
**III. Monitoring, alerting**

![](https://cdn.discordapp.com/attachments/707230681029279768/760248893253746778/unknown.png)

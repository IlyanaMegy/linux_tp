**II. Autres features**
*1. Gestion de boot*
```
$ systemd-analyze blame
          3.139s initrd-switch-root.service
          1.579s dracut-initqueue.service
          700ms tuned.service
```
*2. Gestion de l'heure*
```
[vagrant@node1 ~]$ timedatectl
[...]
       Time zone: UTC (UTC, +0000)
```

*3. Gestion des noms et de la résolution de noms*
```
[vagrant@node1 init.d]$ hostnamectl
   Static hostname: node1
```

```
sudo hostnamectl set-hostname node1new
[vagrant@node1 init.d]$ hostnamectl
   Static hostname: node1new
```
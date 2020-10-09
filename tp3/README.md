## TP3 : systemd

**I. Services systemd**

*1. Intro*

🌞 Utilisez la ligne de commande pour sortir les infos suivantes :

-   **|CLI|** afficher le nombre de _services systemd_ dispos sur la machine
```
[vagrant@vmtp3 ~]$ systemctl list-units --all | tail -2 | head -1 |awk '{print $1;}'
204
```
///
-   **|CLI|** afficher le nombre de _services systemd_ actifs _("running")_ sur la machine
```
[vagrant@vmtp3 ~]$  systemctl list-units --all --state=running | grep "running" | wc -l
24
```
///

-   **|CLI|** afficher la liste des _services systemd_ qui démarrent automatiquement au boot _("enabled")	
```
[vagrant@vmtp3 ~]$ systemctl list-unit-files state=enable | tail -1 | awk '{print $1;}'
0
```
///
-   **|CLI|** afficher le nombre de _services systemd_ qui ont échoué _("failed")_ ou qui sont inactifs _("exited")_ sur la machine_
```
[vagrant@vmtp3 ~]$ systemctl list-units | grep 'exited\|failed' | wc -l
17
```
---
*2. Analyse d'un service*


-   `ExecStart` = indiquer la commande à exécuter au lancement du service
-   `ExecStartPre` = commande à exécuter avant `ExecStart` respectivement
-   `PIDFile` = path de l'identifiant PID du service
-   `Type` = type de service
-   `ExecReload` = commande à executer pour recharger la configuration du service
-   `Description` = donne une description du service
-   `After` = pré-requis nécessaire au fonctionnement du service

🌞 **|CLI|** Listez tous les services qui contiennent la ligne `WantedBy=multi-user.target`
```
grep "WantedBy=multi-user.target" -r .  | cut -d ':' -f 1 | cut -d '/' -f 2
```
---
*3. Création d'un service*
A. Serveur web

```
 [vagrant@vmtp3 system]$ systemctl status web.service
● web.service - Start network service
   Loaded: loaded (/etc/systemd/system/web.service; disabled; vendor preset: disabled)
   Active: active (running) since Thu 2020-10-08 20:06:41 UTC; 3min 1s ago
 Main PID: 3251 (sudo)
   CGroup: /system.slice/web.service
           ‣ 3251 /bin/sudo /bin/python2 -m SimpleHTTPServer 80                                                                                                                                                  
```

```
[vagrant@vmtp3 system]$ curl -L google.com
<!doctype html><html itemscope="" itemtype="http://schema.org/WebPage" lang="fr"><head><meta content="text/html; charset=UTF-8" http-equiv="Content-Type"><meta content="/images/branding/googleg/1x/googleg_standard_color_128dp.png" itemprop="image"><title>Google</title>
```

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
#!/bin/bash
mkdir /home/backup/"backup_site1-$(date +"%d.%m.%Y")_$(date +%H)"
mkdir /home/backup/"backup_site2-$(date +"%d.%m.%Y")_$(date +%H)"

backup_folder_site1="backup_site1-$(date +"%d.%m.%Y")_$(date +%H)"
backup_folder_site2="backup_site2-$(date +"%d.%m.%Y")_$(date +%H)"

# copier tous les fichiers et dossiers vers $backup_folder
for element in $( ls /srv/site1)
do
        sudo cp -f /srv/site1/$element /home/backup/$backup_folder_site1
done

for element in $( ls /srv/site2)
do
        sudo cp -f /srv/site2/$element /home/backup/$backup_folder_site2
done

#archive et compresse le dossier backup
tar -czf $backup_folder_site1.tar.gz --absolute-names /home/backup/$backup_folder_site1
rm -rf $backup_folder_site1
echo "site1 archived"

tar -czf $backup_folder_site2.tar.gz --absolute-names /home/backup/$backup_folder_site2
rm -rf $backup_folder_site2
echo "site2 achived"
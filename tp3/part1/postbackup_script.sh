#!/bin/bash
# nombre max de sauvegardes = 8
# la plus ancienne sauvegarde a été effectuée il y a 8h
backup_folder_site1="backup_site1-$(date +"%d.%m.%Y")_$(date +%H)"
backup_folder_site2="backup_site2-$(date +"%d.%m.%Y")_$(date +%H)"

current_hour=$(date +%H)
potential_oldest=$(($current_hour-8))

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

if [ "$num_file" -eq 8 ]
then
    # supprimer les 7e et 8e sauvegardes les plus anciennes du dossier web_backup
    rm /home/backup/web_backup/backup_site1-$(date +"%d.%m.%Y")_$potential_oldest.tar.gz
    rm /home/backup/web_backup/backup_site2-$(date +"%d.%m.%Y")_$potential_oldest.tar.gz
fi
mv /home/backup/$backup_folder_site1.tar.gz /home/backup/web_backup
mv /home/backup/$backup_folder_site2.tar.gz /home/backup/web_backup
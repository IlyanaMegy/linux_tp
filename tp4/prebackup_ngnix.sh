#!/bin/bash

#modify here name of the file or folder to backup
path=/etc/nginx/nginx.conf
verif_folder=$(ls home/vagrant/backup/nfs| wc -l)

if ["$verif_folder" -ne 0]
then
    #last modification date
    last_modified=$(ls -al home/vagrant/backup/nfs | grep $var |awk '{print $6,$7,$8}')

    modified_element=$(find $path -newermt "$last_modified" | wc -l)
    if ["$modified_element" -eq 0]
    then
        echo "no modification has been made in the folder $path ."
        echo "backup program will end ."
        exit 1
    fi
fi


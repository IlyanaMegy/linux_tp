#!/bin/bash
#check user backup exist
if id "backup" &>/dev/null; then
    echo 'user backup found, program will continue...'
else
    echo 'user not found, program will end'
    exit 1
fi

# check site1/index.html site/index.html exist
if [ $(find /srv -name "site1" | wc -l) -gt 0 ]
then
    if [ $(find /srv/site1 -name "index.html" | wc -l) -eq 0 ]
    then
        echo "no file, program will end"
        exit 1
    fi
else
    echo "no folder, program will end"
    exit 1
fi

if [ $(find /srv -name "site2" | wc -l) -gt 0 ]
then
    if [ $(find /srv/site2 -name "index.html" | wc -l) -eq 0 ]
    then
        echo "no file, program will end"
        exit 1
    fi
else
    echo "no folder, program will end"
    exit 1
fi

#check web_backup exist; if not create it
if [ $(find /home/backup -name "web_backup" | wc -l) -eq 0 ]
then
    mkdir /home/backup/web_backup
    echo "/home/backup/web_backup folder as been created."
fi

#!/bin/bash

#install MariaDB
yum install -y mariadb-server
systemctl start mariadb
systemctl enable mariadb

mysql_secure_installation <<EOF

n
EOF

mysql -u root <<EOF
SET old_passwords=0;
CREATE USER 'giteaserv'@'192.168.4.12' IDENTIFIED BY 'gitea';
CREATE DATABASE giteadb CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci';
GRANT ALL PRIVILEGES ON giteadb.* TO 'giteaserv'@'192.168.4.12';
FLUSH PRIVILEGES;
EOF
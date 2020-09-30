systemctl start firewalld
firewall-cmd --zone=public --permanent --add-port=80/tcp
firewall-cmd --zone=public --permanent --add-port=443/tcp
firewall-cmd --complete-reload

#install also netstat
yum install net-tools -y
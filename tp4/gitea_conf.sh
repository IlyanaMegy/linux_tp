yum install -y git
useradd --no-create-home --system git

sudo firewall-cmd --add-port 3000/tcp --permanent
sudo firewall-cmd --reload 

#install gitea from binary
wget -O gitea https://dl.gitea.io/gitea/1.12.5/gitea-1.12.5-linux-amd64
chmod +x gitea

wget -O gitea.sha256 https://dl.gitea.io/gitea/1.12.5/gitea-1.12.5-linux-amd64.sha256

useradd --system git
echo "git   ALL=(ALL)   NOPASSWD:ALL" >> /etc/sudoers

mkdir -p /var/lib/gitea/{custom,data,log}
chown -R git:git /var/lib/gitea/
chmod -R 750 /var/lib/gitea/
mkdir /etc/gitea
chown root:git /etc/gitea
chmod 770 /etc/gitea

cp -f /home/vagrant/gitea.service /etc/systemd/system/gitea.service

systemctl daemon-reload
systemctl start gitea
#!/usr/bin/env bash

function get_date() {
	DATESTR="$(date +%Y%m%d' '%H:%M:%S)";
	echo $DATESTR;
}

function apt_update {
	echo -e $(get_date)" Running upgrade"
	sudo apt upgrade -y
	echo -e $(get_date)" Running update"
	sudo apt update -y
}

apt_update

APPS=$(cat ./apps.conf)

##################################################################################
# Linux core apps
for APP in $APPS;
do
	{
		echo -e "Installing $APP"
		sudo apt install -y $APP
	}
done

##################################################################################
# Configurations

## SSH
sudo systemctl enable ssh
sudo systemctl start ssh

sudo ufw allow ssh
sudo ufw enable
sudo ufw status

## CNTLM disable
sudo systemctl disable cntlm

# Re-run updates
apt_update

# Bells and whistles
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

for items in source.sh dircolors; do
{
	cp $item /etc/$item
	chmod 777 /etc/$item
}
done

##################################################################################

# Python stuff
for PACKAGE in pandas Cython seaborn lxml anytree jupyter scrapy;
do
	{
		pip3 install $PACKAGE
	}
done

##################################################################################

# Docker (this is tailored for Ubuntu)

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo apt-key fingerprint -y 0EBFCD88 

sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

sudo apt-get update -y
sudo apt-get install -y docker-ce docker-ce-cli containerd.io

sudo groupadd docker

for EACH_USER in $(cat /etc/passwd | grep /home | cut -d ':' -f1);
do {
 echo -e "Adding $EACH_USER to group docker"
 sudo gpasswd -a $EACH_USER docker
}
done

mkdir -p /etc/docker
echo '{"hosts": ["tcp://0.0.0.0:2375", "unix:///var/run/docker.sock"]}' > /etc/docker/daemon.json

##################################################################################

exec ./sourceprofile_installer.sh

# Re-run updates
apt_update

# Profile settings
exec ./profile_settings.sh &

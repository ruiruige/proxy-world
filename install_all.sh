#!/usr/bin/env bash

mkdir ~/install
mkdir ~/install/kcptun
mkdir ~/install/TcpRoute2

mkdir ~/install/auto_script

mkdir /var/log/kcptun/
mkdir /var/log/TcpRoute2/

############################## install software	########################
sudo apt-get install -y vim python python-pip python-dev proxychains

############################## Permit root to log in with password #####
sed -i 's/[ ]*PermitRootLogin[ ]*no[ ]*/PermitRootLogin yes/g' /etc/ssh/sshd_config
sed -i 's/[ ]*PasswordAuthentication[ ]*no[ ]*/PasswordAuthentication yes/g' /etc/ssh/sshd_config
service ssh restart

############################## run other installations #################
./install_shadowsocks.sh

# ./install_serverspeed.sh


############################## other confiturations ####################
# timezone
sudo dpkg-reconfigure tzdata

############################## dns settings ############################
sudo apt-get remove resolvconf -y
sudo rm /etc/resolv.conf
sudo echo "nameserver 8.8.8.8" > /etc/resolv.conf
sudo echo "nameserver 8.8.4.4" >> /etc/resolv.conf

############################## vim config file #########################
cp ./default/.vimrc ~/.vimrc
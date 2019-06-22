#!/usr/bin/env bash

mkdir ~/install
mkdir ~/install/kcptun
mkdir ~/install/TcpRoute2

mkdir ~/install/auto_script

mkdir /var/log/kcptun/
mkdir /var/log/TcpRoute2/

############################## install software	########################
sudo apt-get install -y vim python python-pip python-dev proxychains python3 python3-pip python3-dev screen make
sudo pip3 install click
sudo pip install click
sudo pip install --upgrade pip

# 某些编译会用到
sudo apt-get install autoconf automake libtool -y
sudo apt install -y fail2ban
############################## Permit root to log in with password #####
# sudo sed -i 's/[ ]*PermitRootLogin[ ]*no[ ]*/PermitRootLogin yes/g' /etc/ssh/sshd_config
# sudo sed -i 's/[ ]*PasswordAuthentication[ ]*no[ ]*/PasswordAuthentication yes/g' /etc/ssh/sshd_config
# sudo service ssh restart

############################## run other installations #################
bash ./freeworld//software/shadowsocks/install_shadowsocks.sh
bash ./software/squid/install_squid.sh
# bash ./software/serverspeed/install_serverspeed.sh

############################## other confiturations ####################
# timezone
sudo dpkg-reconfigure tzdata

############################## dns settings ############################
sudo apt-get remove resolvconf -y
sudo rm /etc/resolv.conf
sudo echo "nameserver 8.8.8.8" > /etc/resolv.conf
sudo echo "nameserver 8.8.4.4" >> /etc/resolv.conf

############################## vim config file #########################
cp ./freeworld//default/vimrc.vimrc ~/.vimrc

############################## optimize network ########################
bash ./freeworld/common/network_optimize.sh
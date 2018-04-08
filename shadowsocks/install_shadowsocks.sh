#!/usr/bin/env bash
basepath=$(cd `dirname $0`; pwd)

mkdir ~/install/shadowsocks
mkdir /var/log/shadowsocks/

pip install -y setuptools
pip install shadowsocks

cd ~/install/shadowsocks
wget https://download.libsodium.org/libsodium/releases/LATEST.tar.gz
tar -vxzf ./LATEST.tar.gz

cd libsodium-*
./configure
make 
sudo make install
sudo ldconfig


############################## copy config file	########################
cp $basepath/shadowsocks.json /etc/

# 安装启动项
cp $basepath/shadowsocks.service /lib/systemd/system/
systemctl daemon-reload
systemctl enable shadowsocks
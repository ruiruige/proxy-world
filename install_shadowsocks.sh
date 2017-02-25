#!/usr/bin/env bash

mkdir ~/install/shadowsocks
mkdir /var/log/shadowsocks/

pip install shadowsocks

cd ~/install/shadowsocks
wget https://download.libsodium.org/libsodium/releases/LATEST.tar.gz
tar -vxzf ./LATEST.tar.gz

cd libsodium-1*
./configure
make 
sudo make install
sudo ldconfig


############################## copy config file	########################
cp ./shadowsocks.json /etc/
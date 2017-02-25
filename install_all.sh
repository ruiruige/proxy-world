#!/usr/bin/env bash

mkdir ~/install
mkdir ~/install/kcptun
mkdir ~/install/TcpRoute2
mkdir ~/install/shadowsocks
mkdir ~/install/auto_script

# log directories
mkdir /var/log/kcptun/
mkdir /var/log/TcpRoute2/
mkdir /var/log/shadowsocks/

sudo apt-get install vim python python-pip python-dev 

# run other scripts
./install_shadowsocks.sh

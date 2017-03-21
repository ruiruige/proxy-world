#!/usr/bin/env bash
basepath=$(cd `dirname $0`; pwd)

sudo apt-get install openssl libssl-dev ssl-cert -y
sudo apt-get install devscripts build-essential fakeroot -y
sudo apt-get install apache2-utils -y

mkdir ~/install/squid
cd ~/install/squid

wget http://www.squid-cache.org/Versions/v3/3.5/squid-3.5.24.tar.gz
tar -xvzf squid-3.5.24.tar.gz
cd squid-3.5.24

./configure --enable-ssl --with-open-ssl=/usr/include/openssl
make
sudo make install

cp $basepath/squid.conf /usr/local/squid/etc/

# root 下
useradd squid
mkdir -p /usr/local/squid/var/spool/

chown -R squid /usr/local/squid

sudo python3 $basepath/../utils/config_handler.py --append-boot-cmd --config 'service squid start' -r 'service squid start' -f /etc/rc.local

echo "需要添加账号密码"
echo "需要添加证书"
echo "需要修改配置文件"
echo "需要修改环境变量"
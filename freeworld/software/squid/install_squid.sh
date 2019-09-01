#!/usr/bin/env bash
basepath=$(cd `dirname $0`; pwd)

sudo apt-get install openssl libssl-dev ssl-cert -y
sudo apt-get install devscripts build-essential fakeroot -y
sudo apt-get install apache2-utils -y

mkdir ~/install/squid
cd ~/install/squid

http://www.squid-cache.org/Versions/v4/squid-4.8.tar.gz
tar -xvzf squid-4.8.tar.gz
cd squid-4.8

# ubuntu 18.04自带openssl 1.1.x，squid不兼容这个，具体见这里：https://github.com/squid-cache/squid/pull/333
sed -i s/SSL_library_init/OPENSSL_init_ssl/ configure.ac configure
./configure --enable-ssl --with-openssl=/usr/include/openssl
make
sudo make install

cp ${basepath}/squid.conf /usr/local/squid/etc/

# root 下
useradd squid
mkdir -p /usr/local/squid/var/spool/

chown -R squid /usr/local/squid

# 安装启动项
cp ${basepath}/squid.service /lib/systemd/system/
systemctl daemon-reload
systemctl enable squid

# 把Squid加入环境变量
echo 'export PATH=$PATH:/usr/local/squid/sbin/' >> /etc/profile

echo "需要添加账号密码"
echo "需要添加证书"
echo "需要修改配置文件"
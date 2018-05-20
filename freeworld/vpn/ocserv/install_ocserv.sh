#!/usr/bin/env bash
basepath=$(cd `dirname $0`; pwd)

sudo apt-get install build-essential pkg-config -y  # necessary
sudo apt-get install libgnutls28-dev libev-dev -y   # necessary
sudo apt-get install -y libwrap0-dev                # TCP wrappers
sudo apt-get install -y libpam0g-dev                # PAM
sudo apt-get install -y liblz4-dev                  # LZ4
sudo apt-get install -y libseccomp-dev              # seccomp
sudo apt-get install -y libreadline-dev             # occtl
sudo apt-get install -y libreadline-dev libnl-route-3-dev       # occtl
sudo apt-get install -y libkrb5-dev                 # GSSAPI
sudo apt-get install -y liboath-dev                 # OATH
sudo apt-get install -y libradcli-dev               # Radius

sudo apt-get install libnl-route-3-dev gnutls-bin -y
sudo apt-get install nettle-dev -y


sudo apt-get install -y libprotobuf-c0-dev libprotobuf-c0-dev libtalloc-dev libhttp-parser-dev libpcl1-dev libopts25-dev autogen protobuf-c-compiler gperf liblockfile-bin nuttcp lcov libpam-oath
sudo apt-get install -y libuid-wrapper libpam-wrapper libnss-wrapper libsocket-wrapper  gss-ntlmssp # 16.04

mkdir ~/install/ocserv
mkdir /etc/ocserv

cd ~/install/ocserv
git clone https://gitlab.com/ocserv/ocserv.git

cd ocserv

bash ./autogen.sh
./configure
make
make install

sudo python3 $basepath/../../utils/config_handler.py --set-config --config 'net.ipv4.ip_forward' -r 'net.ipv4.ip_forward=1' -f /etc/sysctl.conf
sudo python3 $basepath/../../utils/config_handler.py --append-boot-cmd --config 'iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE' -r 'iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE' -f /etc/rc.local

# 注册服务
#cd /etc/init.d
#sudo ln -s /lib/init/upstart-job ocserv
#sudo cp $basepath/ocserv_upstart.conf /etc/init/ocserv.conf



# 拷贝配置文件
cp $basepath/ocserv.conf /etc/ocserv/
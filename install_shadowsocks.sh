pip install shadowsocks

cd ~/install/shadowsocks
wget https://download.libsodium.org/libsodium/releases/LATEST.tar.gz
tar -vxzf ./LATEST.tar.gz

cd libsodium-1*
./configure
make && make install
ldconfig
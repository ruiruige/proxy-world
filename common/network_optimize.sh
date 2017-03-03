#!/usr/bin/env bash
# * soft nofile 51200 
# * hard nofile 51200
basepath=$(cd `dirname $0`; pwd)

sudo python3 $basepath/../utils/config_handler.py --set-config --config '* soft nofile' -r '* soft nofile 51200' -f /etc/security/limits.conf
sudo python3 $basepath/../utils/config_handler.py --set-config --config '* hard nofile' -r '* hard nofile 51200' -f /etc/security/limits.conf

# session required pam_limits.so
sudo python3 $basepath/../utils/config_handler.py --set-config --config 'session required ' -r 'session required pam_limits.so' -f /etc/pam.d/common-session

# ulimit -SHn 51200
sudo python3 $basepath/../utils/config_handler.py --set-config --config 'ulimit -SHn ' -r 'ulimit -SHn 51200' -f /etc/profile
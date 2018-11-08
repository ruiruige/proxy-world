#!/usr/bin/env bash

killall ssserver

ssserver -c /etc/shadowsocks.json --log-file /var/log/shadowsocks/shadowsocks.log -d start
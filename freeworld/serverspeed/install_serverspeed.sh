#!/usr/bin/env bash
basepath=$(cd `dirname $0`; pwd)

mkdir ~/install/serverspeed

cp $basepath/serverspeeder-all.sh ~/install/serverspeed/

sudo bash ~/install/serverspeed/serverspeeder-all.sh
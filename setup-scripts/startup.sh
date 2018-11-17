#!/bin/bash


. ./config.sh

set -e

cp startup-scripts/start-ttdnsd.sh /etc/
cp files/rc-local.service /etc/systemd/system/
cp startup-scripts/tor-survey.sh /etc/
cp startup-scripts/rc.local /etc/
chmod +x /etc/start-ttdnsd.sh 
chmod +x /etc/tor-survey.sh
chmod +x /etc/rc.local

systemctl enable rc-local
systemctl start rc-local

#Replace MASTER_DOMAIN
sed -i "s/MASTER_DOMAIN/$MASTER_DOMAIN/g"  /etc/tor-survey.sh

exit 0

#!/bin/bash

while true; do

    killall ttdnsd
    echo "nameserver 127.0.0.1" > /etc/resolv.conf
    sleep 2;
    ttdnsd -l -d >> /var/log/ttdnsd


done

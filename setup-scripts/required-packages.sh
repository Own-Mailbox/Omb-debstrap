#!/bin/bash

#################################################
#	Install debian packages required for omb
#################################################

set -e

DEBIAN_FRONTEND=noninteractive apt-get update
DEBIAN_FRONTEND=noninteractive apt-get install -y apt-utils apt-transport-https
DEBIAN_FRONTEND=noninteractive apt-get remove -y resolvconf openresolv network-manager
systemctl disable systemd-resolved.service
service systemd-resolved stop
DEBIAN_FRONTEND=noninteractive apt-get install -y apache2 build-essential curl dnsutils git gnupg iptables redsocks iptables-persistent libcurl4-openssl-dev libjpeg-dev libxml2-dev libxslt1-dev mysql-server ntpdate openssh-server openssl postfix postfix-mysql postfix-pcre procmail python-dev python-jinja2 python-lxml python-pgpdump python-pip python-virtualenv rsyslog spambayes sudo tor torsocks wget zlib1g-dev qrencode

DEBIAN_FRONTEND=noninteractive apt-get install -y certbot 

service mysql start

exit 0

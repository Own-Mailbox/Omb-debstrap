#!/bin/bash

################################################
#	Install omb sub repositories
# (ihm, cs-com and ttdns)
################################################
set -e

source config.sh

cp config.sh /root/
cd /root/
rm -rf ihm/
git clone https://github.com/Own-Mailbox/Setup-web-interface.git
cp config.sh Setup-web-interface/config.sh
cd Setup-web-interface/
make

cd /root/
rm -rf cs-com/
git clone https://github.com/Own-Mailbox/cs-com
cd cs-com/client/
sed -i request.h -e "s#proxy.omb.one#$FQDN#"
make && make install

cd /root/
rm -rf ttdnsd/
git clone https://github.com/Own-Mailbox/ttdnsd
cd ttdnsd/
make install

exit 0

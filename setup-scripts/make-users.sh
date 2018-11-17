#!/bin/bash

#############################################
#	Create necessary users
#############################################

set -e

mkdir -p /home/www-data/
chown www-data /home/www-data

adduser --disabled-password --system --shell /bin/bash tor
chown -R tor /var/lib/tor/

touch /var/log/tor-consult.log
chown tor /var/log/tor-consult.log
mkdir /var/lib/tor-consult
chown tor  /var/lib/tor-consult

adduser --disabled-password --system --shell /bin/bash mailpile
mkdir -p /home/mailpile
chown mailpile /home/mailpile

touch /var/mail/mailpile
chown mailpile /var/mail/mailpile

exit 0

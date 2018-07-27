#!/bin/sh
#This omb will take subdomains of MASTER_DOMAIN
MASTER_DOMAIN=omb.one

#Proxy location
FQDN=proxy.$MASTER_DOMAIN

#Proxy IP - Do not edit this line!
IP=$(dig +short $FQDN)

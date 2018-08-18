#!/bin/bash

###############################################
#	 Setup and save iptables into the system
###############################################

set -e

if [ -f /.dockerenv ]; then
    echo "Iptables don't work in docker"
    exit 0;
fi

modprobe ip_tables


iptables -F
ip6tables -F


# Accept incoming connections from local network
iptables -A INPUT -s 127.0.0.0/8    -j ACCEPT
iptables -A INPUT -s 192.168.0.0/16 -j ACCEPT
iptables -A INPUT -s 10.0.0.0/8     -j ACCEPT
iptables -A INPUT -s 172.16.0.0/12  -j ACCEPT

# Allow established or related connections
iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

# Drop everyhting else
iptables -A INPUT -j DROP

# Drop DNS outgoing connections
iptables -A OUTPUT -d 192.168.0.0/16 -p udp --destination-port 53 -j DROP
iptables -A OUTPUT -d 10.0.0.0/8     -p udp --destination-port 53 -j DROP
iptables -A OUTPUT -d 172.16.0.0/12  -p udp --destination-port 53 -j DROP

# Accept tor output connections
iptables -A OUTPUT -m owner --uid-owner tor -j ACCEPT

# Accept local network outgoing connections
iptables -A OUTPUT -d 127.0.0.0/8    -j ACCEPT
iptables -A OUTPUT -d 192.168.0.0/16 -j ACCEPT
iptables -A OUTPUT -d 10.0.0.0/8     -j ACCEPT
iptables -A OUTPUT -d 172.16.0.0/12  -j ACCEPT

# Drop all other outgoing connections
iptables -A OUTPUT -j DROP

################################################################
#			REDSOCKS
################################################################

iptables -t nat -N REDSOCKS
iptables -t nat -A REDSOCKS -d 0.0.0.0/8 -j RETURN
iptables -t nat -A REDSOCKS -d 10.0.0.0/8 -j RETURN
iptables -t nat -A REDSOCKS -d 127.0.0.0/8 -j RETURN
iptables -t nat -A REDSOCKS -d 127.0.0.1/8 -j RETURN
iptables -t nat -A REDSOCKS -d 169.254.0.0/16 -j RETURN
iptables -t nat -A REDSOCKS -d 172.16.0.0/12 -j RETURN
iptables -t nat -A REDSOCKS -d 192.168.0.0/16 -j RETURN
iptables -t nat -A REDSOCKS -d 224.0.0.0/4 -j RETURN
iptables -t nat -A REDSOCKS -d 240.0.0.0/4 -j RETURN

#Redirect GPG key server (port 11371) and http(s) protocol to tor
iptables -t nat -A REDSOCKS -p tcp --dport 443 -j REDIRECT --to-ports 12345
iptables -t nat -A REDSOCKS -p tcp --dport 80 -j REDIRECT --to-ports 12345
iptables -t nat -A REDSOCKS -p tcp --dport 11371 -j REDIRECT --to-ports 12345

iptables -t nat -A OUTPUT -m owner --uid-owner tor -j ACCEPT
iptables -t nat -A OUTPUT -p tcp -j REDSOCKS

#Redirect GPG key server (port 11371) protocol and http(s) to tor 
iptables -t nat -A PREROUTING -p tcp --dport 443 -j REDSOCKS
iptables -t nat -A PREROUTING -p tcp --dport 80 -j REDSOCKS
iptables -t nat -A PREROUTING -p tcp --dport 11371 -j REDSOCKS

################################################################
#			IPV6
################################################################

#Drop all outgoing connection except for ::1
ip6tables -A OUTPUT -d ::1 -j ACCEPT
ip6tables -A OUTPUT -j DROP

# Allow connections incoming for ::1
ip6tables -A INPUT -s ::1 -d ::1 -j ACCEPT

# Allow established or related connections
ip6tables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

# Drop everyhting else
ip6tables -A INPUT -j DROP

iptables-save > /etc/iptables/rules.v4
ip6tables-save > /etc/iptables/rules.v6

exit 0

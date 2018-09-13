#!/bin/sh

ip=$(vagrant ssh-config | grep HostName | awk '{print $2}')
echo "Opening http://$ip/"
firefox http://$ip/ 

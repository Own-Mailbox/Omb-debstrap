#!/bin/sh

vagrant up
sleep 3;
sshconfig=$(vagrant ssh-config)
ip=$(printf "$sshconfig" | grep HostName | awk '{print $2}')
ident=$(printf "$sshconfig" | grep IdentityFile | awk '{print $2}')
scp -i $ident -o "StrictHostKeyChecking no" -r ../../debstrap vagrant@$ip:/tmp/
ssh -i $ident -o "StrictHostKeyChecking no" vagrant@$ip  "sudo DEBIAN_FRONTEND=noninteractive apt-get update"
ssh -i $ident -o "StrictHostKeyChecking no" vagrant@$ip  "sudo DEBIAN_FRONTEND=noninteractive  apt-get -y upgrade"
ssh -i $ident -o "StrictHostKeyChecking no" vagrant@$ip  "cd /tmp/debstrap/; sudo  DEBIAN_FRONTEND=noninteractive ./main.sh"
if [ "$?" -eq "0" ]; then
    printf "\e[1;32m Success! Rebooting please wait ( 2 minutes)\e[0m"
    sleep 120;
    printf "\e[1;32 Accessing the web interface at http://$ip/\e[0m"
    firefox http://$ip/ &
else
    echo "\e[1;31mInstallation failed!\e[0m"
fi

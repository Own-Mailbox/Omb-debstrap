Own-Mailbox Debian install
=========
These scripts will allow you to transform a machine running Debian Stretch into an Own-Mailbox.

Installation instructions
----
Before running these steps make sure you have a clean and fresh install of debian Stretch with no particular configuration at all (except network), that is correctly connected to your local network in dhcp.

**WARNING!!!** This will transform your machine into an Own-Mailbox, **do not execute this on a machine that is not exclusively dedicated to hosting Own-Mailbox**. Do not Install on a computer that you use as a desktop or laptop computer. Do not install on a machine that is not on your local network. **If you just want to test you'd probably be better to install it in a virtual machine.**

In order to install Own-Mailbox run this command:

+ ./main.sh

Testing in a virtual machine with Vagrant and qemu
----
Install these packages: vagrant-libvirt qemu-kvm kvm virt-manager. In order to build the own-mailbox vm, run these commands as normal user (your root password will be requested):

+ cd Vagrant
+ ./build-vm.sh

The web interface will open in firefox at the end of the build. You can the re-access it with:

+ ./access-web-gui.sh

You may ssh into the vm with:

+ vagrant ssh

For more details see: https://www.vagrantup.com/docs/getting-started/

Testing with Docker 
-----
It is possible to do a quick test of Own-Mailbox in Docker, so that you don't need a separate machine. You can do this on a laptop.

First install docker on your machine (https://docs.docker.com/engine/installation/linux/debian/)
Make sure you have ipv6 enabled (e.g  dockerd --ipv6 --fixed-cidr-v6 2001:db8:1::/64 & ) https://docs.docker.com/v17.09/engine/userguide/networking/default_network/ipv6/#how-ipv6-works-on-docker

+ Docker/docker.sh build
+ Docker/docker.sh create
+ Docker/docker.sh shell

Then you can access the web interface at the address http://localhost:8085/

Only use this for testing, not in production. There is no guaranty to have optimal security.
For example iptables blocking everything but tor and local network do not work on docker for now.
This will most probably trigger data leaks.



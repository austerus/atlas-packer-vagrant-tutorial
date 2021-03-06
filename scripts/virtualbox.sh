#!/bin/bash

# Bail if we are not running inside VirtualBox.
if [[ `facter virtual` != "virtualbox" ]]; then
    exit 0
fi

apt-get -y remove virtualbox-guest-additions
apt-get -y install linux-generic dkms
apt-get -y install build-essential module-assistant

printf "\nUsing VirtualBox version: "

cat .vbox_version

printf "\nContinue\n"

mkdir -p /mnt/virtualbox
mount -o loop /home/vagrant/VBoxGuest*.iso /mnt/virtualbox
sh /mnt/virtualbox/VBoxLinuxAdditions.run
ln -s /opt/VBoxGuestAdditions-*/lib/VBoxGuestAdditions /usr/lib/VBoxGuestAdditions
umount /mnt/virtualbox
rm -rf /home/vagrant/VBoxGuest*.iso

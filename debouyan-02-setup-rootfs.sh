#!/bin/bash

cat <<END > /etc/apt/sources.list
deb http://debian.inf.tu-dresden.de/debian/ wheezy main contrib non-free
deb-src http://debian.inf.tu-dresden.de/debian/ wheezy main contrib non-free
END

export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
mount -t devpts devpts /dev/pts
mount -t proc proc /proc

export LANG=C
apt-get update
apt-get install apt-utils dialog locales -y
dpkg-reconfigure locales
export LANG=en_US.UTF-8

cat <<END > /etc/network/interfaces
auto lo eth0
iface lo inet loopback
iface eth0 inet dhcp
END

echo ouya > /etc/hostname

cat <<END > /etc/fstab
# /etc/fstab: static file system information.
#
# <file system> <mount point>   <type>  <options>       <dump>  <pass>
/dev/root      /               ext4    noatime,errors=remount-ro 0 1
tmpfs          /tmp            tmpfs   defaults          0       0
/dev/sda1      none            swap    sw                0       0
END

echo 'T0:2345:respawn:/sbin/getty -L ttyS0 115200 linux' >> /etc/inittab
sed -i 's/^\([3-6]:.* tty[3-6]\)/#\1/' /etc/inittab

apt-get install dhcp3-client udev netbase ifupdown iproute openssh-server iputils-ping wget \
net-tools ntpdate ntp vim nano less tzdata console-tools module-init-tools mc \
xfce4 xfce4-goodies totem midori slim -y

adduser --quiet ouya
adduser ouya video
adduser ouya audio
adduser ouya plugdev

passwd root

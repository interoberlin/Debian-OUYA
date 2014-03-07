#!/bin/bash

TARGET=/media/DebOUYAn

mount $TARGET -o remount,exec,dev

debootstrap --verbose --arch armhf --foreign wheezy $TARGET/ http://debian.inf.tu-dresden.de/debian/

apt-get install qemu-user-static binfmt-support
cp /usr/bin/qemu-arm-static $TARGET/usr/bin/

modprobe binfmt_misc
mkdir $TARGET/dev/pts
mount -t devpts devpts $TARGET/dev/pts
mount -t proc proc $TARGET/proc

chroot $TARGET /debootstrap/debootstrap --second-stage


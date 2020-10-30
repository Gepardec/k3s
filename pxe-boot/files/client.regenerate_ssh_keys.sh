#!/bin/bash

cd /nfs/client1
echo "sudo mount --bind /dev dev"
echo "sudo mount --bind /sys sys"
echo "sudo mount --bind /proc proc"
echo "chroot /nfs/client1 'dpkg-reconfigure openssh-server'"
echo "sudo umount dev sys proc"
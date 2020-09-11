#!/bin/bash
directory=$1

cd /nfs/${directory}
echo "sudo mount --bind /dev dev"
echo "sudo mount --bind /sys sys"
echo "sudo mount --bind /proc proc"
echo "chroot /nfs/${directory} 'dpkg-reconfigure openssh-server'"
echo "sudo umount dev sys proc"
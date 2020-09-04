cd /nfs/client1
sudo mount --bind /dev dev
sudo mount --bind /sys sys
sudo mount --bind /proc proc
chroot /nfs/client1 'dpkg-reconfigure openssh-server'
sudo umount dev sys proc
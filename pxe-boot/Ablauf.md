# Ablauf

## Packages installieren

- Required:
    - tftpd-hpa
    - tftpd
    - pxelinux
    - syslinux

- Nice-To-Have: 
    - vim 
    
## Ablauf Step-By-Step

- packages installieren
- static ip addresse konfigurieren
- netzwerk restarten 
- /etc/default/tftpd-hpa anpassen
- sudo systemctl restart tftpd-hpa
- mkdir /srv/tftp/raspbian64
  - entpacktes image dorthin entpacken
- cp /usr/lib/syslinux/modules/bios/ldlinux.c32 /srv/tftp
- cp /usr/lib/syslinux/modules/bios/libutil.c32 /srv/tftp
- cp /usr/lib/syslinux/modules/bios/menu.c32 /srv/tftp
- cp /usr/lib/PXELINUX/pxelinux.0 /srv/tftp
- create directory /srv/tftp/pxelinux.cfg
- cp /vmlinuz /srv/tftp/rasbian64
- cp /initrd.img /srv/tftp/rasbian64

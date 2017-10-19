## buildroot.config
This file sets up the buildroot environment, including filesystems, boot system, target packages, and cross compiler settings. It points to busybox.config and linux.config in this folder. It is the glue that holds this together. 

You can edit this by moving up one directory and tying `make menuconfig`.

## busybox.config
These are the packages included in busybox. Busybox runs the whole show around here. Its basically a big executable that has a bunch of common utilities built in. It is a self contained binary. 

You can edit this by moving up one directory and tying `make busybox-menuconfig`.

## linux.config
This one is all the settings in the kernel. This includes device drivers, filesystem compatibility, loopback devices, etc. You can get lost in this pretty easily. 

You can edit this by moving up one directory and tying `make linux-menuconfig`.

## boot.cmd 
Sets up the u-boot sequence. Sets up a serial console for debugging at 115200 baud and isolates cores 3 and 4 for power saving. This is as basic a boot configuration as you could want. U-boot also supports booting options from USB, FEL, nfs, etc.

## post-build.sh
This runs after the build but before the imaging of the target filesystem. For more information, please see https://github.com/maximeh/buildroot/blob/master/docs/manual/customize-rootfs.txt for more information. 

In this instance it removes files we don't need, and adds some new files in places we need them.

## post-image.sh
This runs at nearly the end. Don't mess with this script unless you know what you're doing. 

## dnsmasq.conf
Sets up the DHCP and TFTP server. Gets copied to rootfs during post-build.sh

## S90pythonhttp and simpleserver
During develepment I could not get lighttpd, darkttpd, etc, serving exectuble files such as wimboot. I tried again with python's SimpleHTTPServer and it 'just worked', so I ran with it. S90pythonhttp is placed in /etc/init.d/ and simply calls a simpleserver, placed in /var/www/data/. 

Simpleserver sets up network interfaces and runs the server in that directory. It sends any and all file accesses to a temp file that lives in RAM. I have no problems with this so far.

## interfaces
Ensures that eth0 is set up as a static IP at 192.168.100.1. All other netboot files point to that address. 

## netboot directory
These get copied to /var/www/data for netboot to work. All subsquent configuration occurs in those .ipxe files, as well as folders with the ISOs or other payloads. 

Python's server allows symlink following, if you choose to hold the bulk of the data in another partition/removable storage. 

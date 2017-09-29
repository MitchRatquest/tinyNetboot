# tinyNetboot
buildroot netboot server in your hand

## Setup

`git clone https://github.com/MitchRatquest/tinyNetboot.git`

`cd tinyNetboot/`

`./create.sh`

Those should pop out a file `sdcard.img` inside of the images/ directory of this repo. That is what you would burn onto the SD card.

I'd recommend partitioning the SD card afterwards to use up all the space on your card, or using USB flash storage.

If you want to add packages or tweak settings, type either `make menuconfig` to change packages/general buildroot settings, `make busybox-menuconfig` for busybox-specific changes, or `make linux-menuconfig` for changes to the kernel. After that, just type `make` to implement the changes. 

## Basic Usage
Netboot uses a DHCP server and a TFTP server for PXE boot, then a no-frills HTTP server for the rest of its usage. All of the storage and serving of the files is locally done. 

The way netboot is currently compiled, it looks for 192.168.100.1, which is what the eth0 port is statically assigned. It then serves files from that IP address using dnsmasq, and python's SimpleHTTPServer. Security doesn't matter as I don't imagine this will be used in a production environment.

I would suggest looking at https://github.com/antonym/netboot.xyz to understand the netboot process. 

This is compiled for the nanopi neo, a tiny $8 computer with USB OTG, ethernet, and the Allwinner H3. This image should work with other H3 based boards, but no guarantees.  

Note that right now, the .ipxe files don't correspond with anything. You'll need to set up the directory structures yourself and edit the files to point to the right places for boot. So far I've gotten windows 7, debian, and tinyCore to boot from this image. 

I imagine the use case for this being computer recovery/repair. Carrying a tiny USB powered computer is easier than a stack of burned DVDs, and setup is usually easier, too. I haven't tested this on an efi system yet.

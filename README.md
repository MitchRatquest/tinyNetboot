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

## Design Considerations
The setup only uses 2 cores, as evident in the boot.cmd, which uboot then uses to set up the environment. It is also clocked at 1.2GHz at boot. If I run the board with 4 cores at that speed, chances are very good it will get stuck in a boot loop by insufficient power over the USB port. You can still use the other two cores using `taskset` if you so choose. 

Right now it'll boot in about 3.5 seconds, which is shorter than the time it takes for the test computer to get into the PXE boot environment. 

USB OTG is enabled, using either legacy or configfs. This might be useful if you want to mount a directory containing drivers, or if you want to set up a USB serial device to the nanopi to tweak some settings.

Dnsmasq is used because it has both a DHCP server and TFTP server capabilities. Python is used as a server because its simple and I don't want to mess around with CGI permissions. Some of the files it tries to grab from the server are executable, and apache/lighttpd/thttpd all failed to serve them. 

Serving files from the SD card results in about 11-12 MB/s, which is what you would expect from the 100Mbs ethernet port. This is still an improvement from my network provider, which is currently 3MB/s. By placing all the ISO/boot files onto a small device I can carry anywhere and power from a USB port, I reduce my dependency on a network connection for the duration of the install/recovery of a computer.

I saw the netboot repo and thought it would be perfect to have on an embedded device. Once I saw it chainloaded to an address, which chainloaded another, and so on and so forth, I thought it'd be very nice to have locally. This is a proof of concept one could build on.

Ideally, it would be ported to the Odroid-HC1, which features a SATA port and gigabit ethernet. The only not-ideal part of that setup is that it cannot be ran from a USB port. This would be remedied by a battery bank powering the unit. It could also serve as a decent debian package repo backup. 



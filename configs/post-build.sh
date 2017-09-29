#!/bin/sh
# post-build.sh for Nanopi NEO, based on the Orange Pi PC
# 2013, Carlo Caione <carlo.caione@gmail.com>
# 2016, "Yann E. MORIN" <yann.morin.1998@free.fr>

BOARD_DIR="$( dirname "${0}" )"
MKIMAGE="${HOST_DIR}/usr/bin/mkimage"
BOOT_CMD="${BOARD_DIR}/boot.cmd"
BOOT_CMD_H="${BINARIES_DIR}/boot.scr"

#copy configuration files to image
#cp $BOARD_DIR/S45ntpdate $TARGET_DIR/etc/init.d
#cp $BOARD_DIR/asound.conf $TARGET_DIR/etc
cp $BOARD_DIR/interfaces $TARGET_DIR/etc/network
#cp $BOARD_DIR/sun8i-h3-nanopi-neo.dtb $IMAGE_DIR/sun8i-h3-nanopi-neo.dtb
#cp $BOARD_DIR/dhcpd.conf $TARGET_DIR/etc/dhcp
#cp $BOARD_DIR/S80dhcp-server $TARGET_DIR/etc/init.d
#cp $BOARD_DIR/S41usb $TARGET_DIR/etc/init.d
#ln -s $TARGET_DIR/usr/bin/wish8.6 $TARGET_DIR/usr/bin/wish
mv $TARGET_DIR/etc/init.d/S40network $TARGET_DIR/etc/init.d/network-disabled

cp $BOARD_DIR/dnsmasq.conf $TARGET_DIR/etc
cp $BOARD_DIR/S90pythonhttp $TARGET_DIR/etc/init.d
cp -r $BOARD_DIR/netboot/* $TARGET_DIR/var/www/data
cp $BOARD_DIR/netboot/netboot.xyz.kpxe $TARGET_DIR/var/lib/tftpboot


# U-Boot script
"${MKIMAGE}" -C none -A arm -T script -d "${BOOT_CMD}" "${BOOT_CMD_H}"

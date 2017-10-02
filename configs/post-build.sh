#!/bin/sh
# post-build.sh for Nanopi NEO, based on the Orange Pi PC
# 2013, Carlo Caione <carlo.caione@gmail.com>
# 2016, "Yann E. MORIN" <yann.morin.1998@free.fr>

BOARD_DIR="$( dirname "${0}" )"
MKIMAGE="${HOST_DIR}/usr/bin/mkimage"
BOOT_CMD="${BOARD_DIR}/boot.cmd"
BOOT_CMD_H="${BINARIES_DIR}/boot.scr"

#copy configuration files to image
mkdir -p $TARGET_DIR/var/www/data
mkdir -p $TARGET_DIR/var/lib/tftpboot

cp $BOARD_DIR/interfaces $TARGET_DIR/etc/network
mv $TARGET_DIR/etc/init.d/S40network $TARGET_DIR/etc/init.d/network-disabled
cp $BOARD_DIR/dnsmasq.conf $TARGET_DIR/etc
cp $BOARD_DIR/S90pythonhttp $TARGET_DIR/etc/init.d
cp -r $BOARD_DIR/netboot/* $TARGET_DIR/var/www/data
cp $BOARD_DIR/netboot/netboot.xyz.kpxe $TARGET_DIR/var/lib/tftpboot

rm $TARGET_DIR/etc/init.d/S30rpcbind
rm $TARGET_DIR/etc/init.d/S50nfs
rm $TARGET_DIR/etc/init.d/autofs
rm $TARGET_DIR/etc/init.d/S60nfs

# U-Boot script
"${MKIMAGE}" -C none -A arm -T script -d "${BOOT_CMD}" "${BOOT_CMD_H}"

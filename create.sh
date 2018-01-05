#!/bin/bash
VERSION=2017.05-rc2

if [ ! -d buildroot-"$VERSION" ]
then
	wget https://git.busybox.net/buildroot/snapshot/buildroot-"$VERSION".tar.gz
	tar zvxf buildroot-"$VERSION".tar.gz
fi

cd buildroot-"$VERSION"
patch -p1 < ../patches/buildroot/0000-apt-cacher-ng.patch
cd ..

make O=$PWD -C buildroot-2017.05-rc2/ defconfig BR2_DEFCONFIG=../configs/buildroot.config
make


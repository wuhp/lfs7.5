#!/bin/bash

export SOURCE="grub-2.00"

[ -d ${SOURCE} ] & rm -rf ${SOURCE}

tar -Jxf ../sources/grub-2.00.tar.xz

cd ${SOURCE}
sed -i -e '/gets is a/d' grub-core/gnulib/stdio.in.h
./configure --prefix=/usr          \
            --sbindir=/sbin        \
            --sysconfdir=/etc      \
            --disable-grub-emu-usb \
            --disable-efiemu       \
            --disable-werror

make
make install

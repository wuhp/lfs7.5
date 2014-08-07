#!/bin/bash

export SOURCE="kmod-16"

[ -d ${SOURCE} ] & rm -rf ${SOURCE}

tar -Jxf ../sources/kmod-16.tar.xz

cd ${SOURCE}
./configure --prefix=/usr          \
            --bindir=/bin          \
            --sysconfdir=/etc      \
            --with-rootlibdir=/lib \
            --disable-manpages     \
            --with-xz              \
            --with-zlib
make
# make check
make install
make -C man install

for target in depmod insmod modinfo modprobe rmmod; do
  ln -sv ../bin/kmod /sbin/$target
done

ln -sv kmod /bin/lsmod

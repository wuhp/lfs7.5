#!/bin/bash

export SOURCE="kbd-2.0.1"

[ -d ${SOURCE} ] & rm -rf ${SOURCE}

tar -zxf ../sources/kbd-2.0.1.tar.gz

cd ${SOURCE}
patch -Np1 -i ../kbd-2.0.1-backspace-1.patch
sed -i 's/\(RESIZECONS_PROGS=\)yes/\1no/g' configure
sed -i 's/resizecons.8 //' docs/man/man8/Makefile.in

PKG_CONFIG_PATH=/tools/lib/pkgconfig ./configure --prefix=/usr --disable-vlock

make
# make check
make install

mkdir -v       /usr/share/doc/kbd-2.0.1
cp -R -v docs/doc/* /usr/share/doc/kbd-2.0.1

#!/bin/bash

export SOURCE="iproute2-3.12.0"

[ -d ${SOURCE} ] & rm -rf ${SOURCE}

tar -Jxf ../sources/iproute2-3.12.0.tar.xz

cd ${SOURCE}
sed -i '/^TARGETS/s@arpd@@g' misc/Makefile
sed -i /ARPD/d Makefile
sed -i 's/arpd.8//' man/man8/Makefile

make DESTDIR=
make DESTDIR=              \
     MANDIR=/usr/share/man \
     DOCDIR=/usr/share/doc/iproute2-3.12.0 install


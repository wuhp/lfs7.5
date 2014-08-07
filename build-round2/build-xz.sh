#!/bin/bash

export SOURCE="xz-5.0.5"

[ -d ${SOURCE} ] & rm -rf ${SOURCE}

tar -Jxf ../sources/xz-5.0.5.tar.xz

cd ${SOURCE}
./configure --prefix=/usr --docdir=/usr/share/doc/xz-5.0.5
make
# make check
make install
mv -v   /usr/bin/{lzma,unlzma,lzcat,xz,unxz,xzcat} /bin
mv -v /usr/lib/liblzma.so.* /lib
ln -svf ../../lib/$(readlink /usr/lib/liblzma.so) /usr/lib/liblzma.so

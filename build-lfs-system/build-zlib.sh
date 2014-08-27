#!/bin/bash

export SOURCE="zlib-1.2.8"

[ -d ${SOURCE} ] & rm -rf ${SOURCE}

tar -Jxf ../sources/zlib-1.2.8.tar.xz
cd ${SOURCE}
./configure --prefix=/usr
make
#make check
make install

mv -v /usr/lib/libz.so.* /lib
ln -sfv ../../lib/$(readlink /usr/lib/libz.so) /usr/lib/libz.so

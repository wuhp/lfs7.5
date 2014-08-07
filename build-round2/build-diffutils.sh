#!/bin/bash

export SOURCE="diffutils-3.3"

[ -d ${SOURCE} ] & rm -rf ${SOURCE}

tar -Jxf ../sources/diffutils-3.3.tar.xz

cd ${SOURCE}
sed -i 's:= @mkdir_p@:= /bin/mkdir -p:' po/Makefile.in.in
./configure --prefix=/usr
make
# make check
make install

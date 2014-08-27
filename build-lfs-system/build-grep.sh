#!/bin/bash

export SOURCE="grep-2.16"

[ -d ${SOURCE} ] & rm -rf ${SOURCE}

tar -Jxf ../sources/grep-2.16.tar.xz

cd ${SOURCE}
./configure --prefix=/usr --bindir=/bin
make
# make check
make install

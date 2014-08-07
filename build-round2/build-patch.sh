#!/bin/bash

export SOURCE="patch-2.7.1"

[ -d ${SOURCE} ] & rm -rf ${SOURCE}

tar -Jxf ../sources/patch-2.7.1.tar.xz

cd ${SOURCE}
./configure --prefix=/usr
make
# make check
make install

#!/bin/bash

export SOURCE="m4-1.4.17"

[ -d ${SOURCE} ] & rm -rf ${SOURCE}

tar -Jxf ../sources/m4-1.4.17.tar.xz

cd ${SOURCE}
./configure --prefix=/usr
make
# make check
make install

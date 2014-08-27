#!/bin/bash

export SOURCE="autoconf-2.69"

[ -d ${SOURCE} ] & rm -rf ${SOURCE}

tar -Jxf ../sources/autoconf-2.69.tar.xz

cd ${SOURCE}
./configure --prefix=/usr
make
# make check
make install

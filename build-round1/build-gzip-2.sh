#!/bin/bash

export SOURCE="gzip-1.6"

[ -d ${SOURCE} ] & rm -rf ${SOURCE}

tar -Jxf ../sources/gzip-1.6.tar.xz

cd ${SOURCE}
./configure --prefix=/tools
make
# make check
make install

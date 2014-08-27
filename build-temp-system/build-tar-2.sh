#!/bin/bash

export SOURCE="tar-1.27.1"

[ -d ${SOURCE} ] & rm -rf ${SOURCE}

tar -Jxf ../sources/tar-1.27.1.tar.xz

cd ${SOURCE}
./configure --prefix=/tools
make
# make check
make install

#!/bin/bash

export SOURCE="diffutils-3.3"

[ -d ${SOURCE} ] & rm -rf ${SOURCE}

tar -Jxf ../sources/diffutils-3.3.tar.xz

cd ${SOURCE}
./configure --prefix=/tools
make
# make check
make install

#!/bin/bash

export SOURCE="xz-5.0.5"

[ -d ${SOURCE} ] & rm -rf ${SOURCE}

tar -Jxf ../sources/xz-5.0.5.tar.xz

cd ${SOURCE}
./configure --prefix=/tools
make
# make check
make install

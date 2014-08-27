#!/bin/bash

export SOURCE="gawk-4.1.0"

[ -d ${SOURCE} ] & rm -rf ${SOURCE}

tar -Jxf ../sources/gawk-4.1.0.tar.xz

cd ${SOURCE}
./configure --prefix=/tools
make
# make check
make install

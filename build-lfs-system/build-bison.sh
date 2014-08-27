#!/bin/bash

export SOURCE="bison-3.0.2"

[ -d ${SOURCE} ] & rm -rf ${SOURCE}

tar -Jxf ../sources/bison-3.0.2.tar.xz
cd ${SOURCE}
./configure --prefix=/usr
make
#make check
make install

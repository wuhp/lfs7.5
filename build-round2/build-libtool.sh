#!/bin/bash

export SOURCE="libtool-2.4.2"

[ -d ${SOURCE} ] & rm -rf ${SOURCE}

tar -zxf ../sources/libtool-2.4.2.tar.gz

cd ${SOURCE}
./configure --prefix=/usr
make
# make check
make install

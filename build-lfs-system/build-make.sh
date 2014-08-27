#!/bin/bash

export SOURCE="make-4.0"

[ -d ${SOURCE} ] & rm -rf ${SOURCE}

tar -jxf ../sources/make-4.0.tar.bz2

cd ${SOURCE}
./configure --prefix=/usr
make
# make check
make install

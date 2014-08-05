#!/bin/bash

export SOURCE="make-4.0"

[ -d ${SOURCE} ] & rm -rf ${SOURCE}

tar -jxf ../sources/make-4.0.tar.bz2

cd ${SOURCE}
./configure --prefix=/tools --without-guile
make
# make check
make install

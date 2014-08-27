#!/bin/bash

export SOURCE="libpipeline-1.2.6"

[ -d ${SOURCE} ] & rm -rf ${SOURCE}

tar -zxf ../sources/libpipeline-1.2.6.tar.gz

cd ${SOURCE}
PKG_CONFIG_PATH=/tools/lib/pkgconfig ./configure --prefix=/usr
make
# make check
make install

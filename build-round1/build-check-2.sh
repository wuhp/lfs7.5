#!/bin/bash

export SOURCE="check-0.9.12"

[ -d ${SOURCE} ] & rm -rf ${SOURCE}

tar -zxf ../sources/check-0.9.12.tar.gz

cd ${SOURCE}
PKG_CONFIG= ./configure --prefix=/tools
make
#make check
make install

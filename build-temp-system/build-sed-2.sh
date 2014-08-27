#!/bin/bash

export SOURCE="sed-4.2.2"

[ -d ${SOURCE} ] & rm -rf ${SOURCE}

tar -jxf ../sources/sed-4.2.2.tar.bz2

cd ${SOURCE}
./configure --prefix=/tools
make
# make check
make install

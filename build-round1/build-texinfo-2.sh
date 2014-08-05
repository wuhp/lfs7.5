#!/bin/bash

export SOURCE="texinfo-5.2"

[ -d ${SOURCE} ] & rm -rf ${SOURCE}

tar -Jxf ../sources/texinfo-5.2.tar.xz

cd ${SOURCE}
./configure --prefix=/tools
make
# make check
make install

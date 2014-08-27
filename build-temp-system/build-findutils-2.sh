#!/bin/bash

export SOURCE="findutils-4.4.2"

[ -d ${SOURCE} ] & rm -rf ${SOURCE}

tar -zxf ../sources/findutils-4.4.2.tar.gz

cd ${SOURCE}
./configure --prefix=/tools
make
# make check
make install

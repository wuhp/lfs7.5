#!/bin/bash

export SOURCE="file-5.17"

[ -d ${SOURCE} ] & rm -rf ${SOURCE}

tar -zxf ../sources/file-5.17.tar.gz

cd ${SOURCE}
./configure --prefix=/tools
make
# make check
make install

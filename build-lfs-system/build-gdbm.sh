#!/bin/bash

export SOURCE="gdbm-1.11"

[ -d ${SOURCE} ] & rm -rf ${SOURCE}

tar -zxf ../sources/gdbm-1.11.tar.gz

cd ${SOURCE}
./configure --prefix=/usr --enable-libgdbm-compat
make
# make check
make install

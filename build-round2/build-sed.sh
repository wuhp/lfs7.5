#!/bin/bash

export SOURCE="sed-4.2.2"

[ -d ${SOURCE} ] & rm -rf ${SOURCE}

tar -jxf ../sources/sed-4.2.2.tar.bz2

cd ${SOURCE}
./configure --prefix=/usr --bindir=/bin --htmldir=/usr/share/doc/sed-4.2.2
make
make html
# make check
make install
make -C doc install-html


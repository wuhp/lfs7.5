#!/bin/bash

export SOURCE="gawk-4.1.0"

[ -d ${SOURCE} ] & rm -rf ${SOURCE}

tar -Jxf ../sources/gawk-4.1.0.tar.xz

cd ${SOURCE}
./configure --prefix=/usr
make
# make check
make install

mkdir -v /usr/share/doc/gawk-4.1.0
cp    -v doc/{awkforai.txt,*.{eps,pdf,jpg}} /usr/share/doc/gawk-4.1.0

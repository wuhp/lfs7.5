#!/bin/bash

export SOURCE="mpfr-3.1.2"

[ -d ${SOURCE} ] & rm -rf ${SOURCE}

tar -Jxf ../sources/mpfr-3.1.2.tar.xz
cd ${SOURCE}
./configure --prefix=/usr        \
            --enable-thread-safe \
            --docdir=/usr/share/doc/mpfr-3.1.2
make
#make check
make install

make html
make install-html

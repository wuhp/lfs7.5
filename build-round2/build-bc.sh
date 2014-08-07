#!/bin/bash

export SOURCE="bc-1.06.95"

[ -d ${SOURCE} ] & rm -rf ${SOURCE}

tar -jxf ../sources/bc-1.06.95.tar.bz2

cd ${SOURCE}
./configure --prefix=/usr           \
            --with-readline         \
            --mandir=/usr/share/man \
            --infodir=/usr/share/info

make
# echo "quit" | ./bc/bc -l Test/checklib.b
make install

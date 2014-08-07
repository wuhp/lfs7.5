#!/bin/bash

export SOURCE="man-db-2.6.6"

[ -d ${SOURCE} ] & rm -rf ${SOURCE}

tar -Jxf ../sources/man-db-2.6.6.tar.xz

cd ${SOURCE}
./configure --prefix=/usr                        \
            --docdir=/usr/share/doc/man-db-2.6.6 \
            --sysconfdir=/etc                    \
            --disable-setuid                     \
            --with-browser=/usr/bin/lynx         \
            --with-vgrind=/usr/bin/vgrind        \
            --with-grap=/usr/bin/grap
make
# make check
make install

#!/bin/bash

export SOURCE="pkg-config-0.28"

[ -d ${SOURCE} ] & rm -rf ${SOURCE}

tar -zxf ../sources/pkg-config-0.28.tar.gz
cd ${SOURCE}
./configure --prefix=/usr         \
            --with-internal-glib  \
            --disable-host-tool   \
            --docdir=/usr/share/doc/pkg-config-0.28
make
#make check
make install

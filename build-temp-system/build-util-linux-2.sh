#!/bin/bash

export SOURCE="util-linux-2.24.1"

[ -d ${SOURCE} ] & rm -rf ${SOURCE}

tar -Jxf ../sources/util-linux-2.24.1.tar.xz

cd ${SOURCE}
./configure --prefix=/tools                \
            --disable-makeinstall-chown    \
            --without-systemdsystemunitdir \
            PKG_CONFIG=""
make
make install

#!/bin/bash

export SOURCE="gettext-0.18.3.2"

[ -d ${SOURCE} ] & rm -rf ${SOURCE}

tar -zxf ../sources/gettext-0.18.3.2.tar.gz

cd ${SOURCE}
./configure --prefix=/usr --docdir=/usr/share/doc/gettext-0.18.3.2
make
# make check
make install

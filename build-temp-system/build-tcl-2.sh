#!/bin/bash

export SOURCE="tcl8.6.1"

[ -d ${SOURCE} ] & rm -rf ${SOURCE}

tar -zxf ../sources/tcl8.6.1-src.tar.gz
cd ${SOURCE}
cd unix
./configure --prefix=/tools
make
#TZ=UTC make test
make install
chmod -v u+w /tools/lib/libtcl8.6.so
make install-private-headers
ln -sv tclsh8.6 /tools/bin/tclsh

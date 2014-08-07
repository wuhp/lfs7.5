#!/bin/bash

export SOURCE="automake-1.14.1"

[ -d ${SOURCE} ] & rm -rf ${SOURCE}

tar -Jxf ../sources/automake-1.14.1.tar.xz

cd ${SOURCE}
./configure --prefix=/usr --docdir=/usr/share/doc/automake-1.14.1
make
# sed -i "s:./configure:LEXLIB=/usr/lib/libfl.a &:" t/lex-{clean,depend}-cxx.sh
# make check
make install

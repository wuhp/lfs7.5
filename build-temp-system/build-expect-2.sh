#!/bin/bash

export SOURCE="expect5.45"

[ -d ${SOURCE} ] & rm -rf ${SOURCE}

tar -zxf ../sources/expect5.45.tar.gz

cd ${SOURCE}
cp -v configure{,.orig}
sed 's:/usr/local/bin:/bin:' configure.orig > configure
./configure --prefix=/tools       \
            --with-tcl=/tools/lib \
            --with-tclinclude=/tools/include
make
#make test
make SCRIPTS="" install

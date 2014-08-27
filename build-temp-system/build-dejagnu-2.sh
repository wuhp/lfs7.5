#!/bin/bash

export SOURCE="dejagnu-1.5.1"

[ -d ${SOURCE} ] & rm -rf ${SOURCE}

tar -zxf ../sources/dejagnu-1.5.1.tar.gz

cd ${SOURCE}
./configure --prefix=/tools
make install
#make check

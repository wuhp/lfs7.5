#!/bin/bash

export SOURCE="mpc-1.0.2"

[ -d ${SOURCE} ] & rm -rf ${SOURCE}

tar -zxf ../sources/mpc-1.0.2.tar.gz
cd ${SOURCE}
./configure --prefix=/usr 
make
#make check
make install

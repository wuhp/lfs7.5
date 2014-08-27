#!/bin/bash

export SOURCE="coreutils-8.22"

[ -d ${SOURCE} ] & rm -rf ${SOURCE}

tar -Jxf ../sources/coreutils-8.22.tar.xz

cd ${SOURCE}
./configure --prefix=/tools --enable-install-program=hostname

make
# make RUN_EXPENSIVE_TESTS=yes check
make install

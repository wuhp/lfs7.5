#!/bin/bash

export SOURCE="bash-4.2"

[ -d ${SOURCE} ] & rm -rf ${SOURCE}

tar -zxf ../sources/bash-4.2.tar.gz

cd ${SOURCE}
patch -Np1 -i ../../sources/bash-4.2-fixes-12.patch
./configure --prefix=/tools --without-bash-malloc

make
#make tests
make install
ln -sv bash /tools/bin/sh

#!/bin/bash

export SOURCE="ncurses-5.9"

[ -d ${SOURCE} ] & rm -rf ${SOURCE}

tar -zxf ../sources/ncurses-5.9.tar.gz

cd ${SOURCE}
./configure --prefix=/tools \
            --with-shared   \
            --without-debug \
            --without-ada   \
            --enable-widec  \
            --enable-overwrite

make
make install

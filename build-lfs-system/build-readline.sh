#!/bin/bash

export SOURCE="readline-6.2"

[ -d ${SOURCE} ] & rm -rf ${SOURCE}

tar -zxf ../sources/readline-6.2.tar.gz

cd ${SOURCE}
sed -i '/MV.*old/d' Makefile.in
sed -i '/{OLDSUFF}/c:' support/shlib-install

patch -Np1 -i ../../sources/readline-6.2-fixes-2.patch

./configure --prefix=/usr
make SHLIB_LIBS=-lncurses
make install

mv -v /usr/lib/lib{readline,history}.so.* /lib
ln -sfv ../../lib/$(readlink /usr/lib/libreadline.so) /usr/lib/libreadline.so
ln -sfv ../../lib/$(readlink /usr/lib/libhistory.so ) /usr/lib/libhistory.so

mkdir   -v /usr/share/doc/readline-6.2
install -v -m644 doc/*.{ps,pdf,html,dvi} /usr/share/doc/readline-6.2

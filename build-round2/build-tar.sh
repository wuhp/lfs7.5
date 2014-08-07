#!/bin/bash

export SOURCE="tar-1.27.1"

[ -d ${SOURCE} ] & rm -rf ${SOURCE}

tar -Jxf ../sources/tar-1.27.1.tar.xz

cd ${SOURCE}
patch -Np1 -i ../../sources/tar-1.27.1-manpage-1.patch
FORCE_UNSAFE_CONFIGURE=1  \
./configure --prefix=/usr \
            --bindir=/bin
make
# make check
make install
make -C doc install-html docdir=/usr/share/doc/tar-1.27.1

perl tarman > /usr/share/man/man1/tar.1

#!/bin/bash

export SOURCE="gzip-1.6"

[ -d ${SOURCE} ] & rm -rf ${SOURCE}

tar -Jxf ../sources/gzip-1.6.tar.xz

cd ${SOURCE}
./configure --prefix=/usr --bindir=/bin
make
# make check
make install

mv -v /bin/{gzexe,uncompress,zcmp,zdiff,zegrep} /usr/bin
mv -v /bin/{zfgrep,zforce,zgrep,zless,zmore,znew} /usr/bin

#!/bin/bash

export SOURCE="groff-1.22.2"

[ -d ${SOURCE} ] & rm -rf ${SOURCE}

tar -zxf ../sources/groff-1.22.2.tar.gz

cd ${SOURCE}
PAGE=A4 ./configure --prefix=/usr
make
make install

ln -sv eqn /usr/bin/geqn
ln -sv tbl /usr/bin/gtbl

#!/bin/bash

export SOURCE="findutils-4.4.2"

[ -d ${SOURCE} ] & rm -rf ${SOURCE}

tar -zxf ../sources/findutils-4.4.2.tar.gz

cd ${SOURCE}
./configure --prefix=/usr --localstatedir=/var/lib/locate
make
# make check
make install

mv -v /usr/bin/find /bin
sed -i 's/find:=${BINDIR}/find:=\/bin/' /usr/bin/updatedb


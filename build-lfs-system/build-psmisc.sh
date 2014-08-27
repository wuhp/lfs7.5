#!/bin/bash

export SOURCE="psmisc-22.20"

[ -d ${SOURCE} ] & rm -rf ${SOURCE}

tar -zxf ../sources/psmisc-22.20.tar.gz 
cd ${SOURCE}
./configure --prefix=/usr
make
make install

mv -v /usr/bin/fuser   /bin
mv -v /usr/bin/killall /bin

#!/bin/bash

export SOURCE="texinfo-5.2"

[ -d ${SOURCE} ] & rm -rf ${SOURCE}

tar -Jxf ../sources/texinfo-5.2.tar.xz

cd ${SOURCE}
./configure --prefix=/usr
make
# make check
make install
make TEXMF=/usr/share/texmf install-tex

cd /usr/share/info
rm -v dir
for f in *
do install-info $f dir 2>/dev/null
done

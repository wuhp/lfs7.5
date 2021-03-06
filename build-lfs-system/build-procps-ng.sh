#!/bin/bash

export SOURCE="procps-ng-3.3.9"

[ -d ${SOURCE} ] & rm -rf ${SOURCE}

tar -Jxf ../sources/procps-ng-3.3.9.tar.xz
cd ${SOURCE}
./configure --prefix=/usr                           \
            --exec-prefix=                          \
            --libdir=/usr/lib                       \
            --docdir=/usr/share/doc/procps-ng-3.3.9 \
            --disable-static                        \
            --disable-kill

make
# sed -i -r 's|(pmap_initname)\\\$|\1|' testsuite/pmap.test/pmap.exp
# make check
make install

mv -v /usr/bin/pidof /bin
mv -v /usr/lib/libprocps.so.* /lib
ln -sfv ../../lib/$(readlink /usr/lib/libprocps.so) /usr/lib/libprocps.so


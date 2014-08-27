#!/bin/bash

export SOURCE="bash-4.2"

[ -d ${SOURCE} ] & rm -rf ${SOURCE}

tar -zxf ../sources/bash-4.2.tar.gz

cd ${SOURCE}
patch -Np1 -i ../../sources/bash-4.2-fixes-12.patch
./configure --prefix=/usr                     \
            --bindir=/bin                     \
            --htmldir=/usr/share/doc/bash-4.2 \
            --without-bash-malloc             \
            --with-installed-readline

make

# chown -Rv nobody .
# su nobody -s /bin/bash -c "PATH=$PATH make tests"

make install

# exec /bin/bash --login +h

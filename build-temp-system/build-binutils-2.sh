#!/bin/bash

export SOURCE="binutils-2.24"
export BUILD="binutils-build-2"

[ -d ${SOURCE} ] & rm -rf ${SOURCE}
[ -d ${BUILD} ] & rm -rf ${BUILD}

tar -jxf ../sources/binutils-2.24.tar.bz2
mkdir -p ${BUILD}
cd ${BUILD}

CC=$LFS_TGT-gcc                \
AR=$LFS_TGT-ar                 \
RANLIB=$LFS_TGT-ranlib         \
../${SOURCE}/configure         \
    --prefix=/tools            \
    --disable-nls              \
    --with-lib-path=/tools/lib \
    --with-sysroot

make
make install

make -C ld clean
make -C ld LIB_PATH=/usr/lib:/lib
cp -v ld/ld-new /tools/bin

#!/bin/bash

export SOURCE="binutils-2.24"
export BUILD="binutils-build-1"

[ -d ${SOURCE} ] & rm -rf ${SOURCE}
[ -d ${BUILD} ] & rm -rf ${BUILD}

tar -jxf ../sources/binutils-2.24.tar.bz2
mkdir -p ${BUILD}
cd ${BUILD}
../${SOURCE}/configure     \
    --prefix=/tools            \
    --with-sysroot=$LFS        \
    --with-lib-path=/tools/lib \
    --target=$LFS_TGT          \
    --disable-nls              \
    --disable-werror
make
make install

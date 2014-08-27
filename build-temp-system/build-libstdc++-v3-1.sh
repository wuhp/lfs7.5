#!/bin/bash

export SOURCE="gcc-4.8.2"
export BUILD="std-build-1"

[ -d ${SOURCE} ] & rm -rf ${SOURCE}
[ -d ${BUILD} ] & rm -rf ${BUILD}

tar -jxf ../sources/gcc-4.8.2.tar.bz2

mkdir -p ${BUILD}
cd ${BUILD}
../${SOURCE}/libstdc++-v3/configure     \
    --host=$LFS_TGT                 \
    --prefix=/tools                 \
    --disable-multilib              \
    --disable-shared                \
    --disable-nls                   \
    --disable-libstdcxx-threads     \
    --disable-libstdcxx-pch         \
    --with-gxx-include-dir=/tools/$LFS_TGT/include/c++/4.8.2
make
make install


#!/bin/bash

export SOURCE="glibc-2.19"
export BUILD="glibc-build-1"

[ -d ${SOURCE} ] & rm -rf ${SOURCE}
[ -d ${BUILD} ] & rm -rf ${BUILD}

tar -Jxf ../sources/glibc-2.19.tar.xz
mkdir -p ${BUILD}
cd ${BUILD}
../${SOURCE}/configure     \
      --prefix=/tools                               \
      --host=$LFS_TGT                               \
      --build=$(../${SOURCE}/scripts/config.guess)  \
      --disable-profile                             \
      --enable-kernel=2.6.32                        \
      --with-headers=/tools/include                 \
      libc_cv_forced_unwind=yes                     \
      libc_cv_ctors_header=yes                      \
      libc_cv_c_cleanup=yes

make
make install

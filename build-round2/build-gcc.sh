#!/bin/bash

export SOURCE="gcc-4.8.2"
export BUILD="gcc-build"

[ -d ${SOURCE} ] & rm -rf ${SOURCE}
[ -d ${BUILD} ] & rm -rf ${BUILD}

tar -jxf ../sources/gcc-4.8.2.tar.bz2

cd ${SOURCE}
case `uname -m` in
  i?86) sed -i 's/^T_CFLAGS =$/& -fomit-frame-pointer/' gcc/Makefile.in ;;
esac
sed -i -e /autogen/d -e /check.sh/d fixincludes/Makefile.in 
mv -v libmudflap/testsuite/libmudflap.c++/pass41-frag.cxx{,.disable}
cd ..

mkdir -p ${BUILD}
cd ${BUILD}

SED=sed                          \
../${SOURCE}/configure           \
     --prefix=/usr               \
     --enable-shared             \
     --enable-threads=posix      \
     --enable-__cxa_atexit       \
     --enable-clocale=gnu        \
     --enable-languages=c,c++    \
     --disable-multilib          \
     --disable-bootstrap         \
     --with-system-zlib

make
#ulimit -s 32768
#make -k check
make install

ln -sv ../usr/bin/cpp /lib
ln -sv gcc /usr/bin/cc

mkdir -pv /usr/share/gdb/auto-load/usr/lib
mv -v /usr/lib/*gdb.py /usr/share/gdb/auto-load/usr/lib

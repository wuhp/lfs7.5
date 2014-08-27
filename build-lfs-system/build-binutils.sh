#!/bin/bash

export SOURCE="binutils-2.24"
export BUILD="binutils-build"

[ -d ${SOURCE} ] & rm -rf ${SOURCE}
[ -d ${BUILD} ] & rm -rf ${BUILD}

tar -jxf ../sources/binutils-2.24.tar.bz2
cd ${SOURCE}
rm -fv etc/standards.info
sed -i.bak '/^INFO/s/standards.info //' etc/Makefile.in
cd ..

mkdir -p ${BUILD}
cd ${BUILD}
../${SOURCE}/configure --prefix=/usr --enable-shared
make tooldir=/usr
make check
make tooldir=/usr install

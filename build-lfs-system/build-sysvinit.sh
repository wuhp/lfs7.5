#!/bin/bash

export SOURCE="sysvinit-2.88dsf"

[ -d ${SOURCE} ] & rm -rf ${SOURCE}

tar -jxf ../sources/sysvinit-2.88dsf.tar.bz2

cd ${SOURCE}
patch -Np1 -i ../../sources/sysvinit-2.88dsf-consolidated-1.patch
make -C src
make -C src install

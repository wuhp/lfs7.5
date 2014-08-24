#!/bin/bash

export SOURCE="lfs-bootscripts-20130821"

[ -d ${SOURCE} ] & rm -rf ${SOURCE}

tar -jxf ../sources/lfs-bootscripts-20130821.tar.bz2

cd ${SOURCE}
make install

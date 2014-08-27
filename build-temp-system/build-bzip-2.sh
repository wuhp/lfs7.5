#!/bin/bash

export SOURCE="bzip2-1.0.6"

[ -d ${SOURCE} ] & rm -rf ${SOURCE}

tar -zxf ../sources/bzip2-1.0.6.tar.gz

cd ${SOURCE}
make
make PREFIX=/tools install

#!/bin/bash

export SOURCE="less-458"

[ -d ${SOURCE} ] & rm -rf ${SOURCE}

tar -zxf ../sources/less-458.tar.gz

cd ${SOURCE}
./configure --prefix=/usr --sysconfdir=/etc
make
make install

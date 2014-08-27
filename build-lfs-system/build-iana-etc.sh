#!/bin/bash

export SOURCE="iana-etc-2.30"

[ -d ${SOURCE} ] & rm -rf ${SOURCE}

tar -jxf ../sources/iana-etc-2.30.tar.bz2
cd ${SOURCE}
make
make install


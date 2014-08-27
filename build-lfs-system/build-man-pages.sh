#!/bin/bash

export SOURCE="man-pages-3.59"

[ -d ${SOURCE} ] & rm -rf ${SOURCE}

tar -Jxf ../sources/man-pages-3.59.tar.xz
cd ${SOURCE}
make install

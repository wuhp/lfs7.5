#!/bin/bash

export SOURCE="linux-3.13.3"

[ -d ${SOURCE} ] & rm -rf ${SOURCE}

tar -Jxf ../sources/linux-3.13.3.tar.xz
cd ${SOURCE}
make mrproper
make headers_check
make INSTALL_HDR_PATH=dest headers_install
cp -rv dest/include/* /tools/include



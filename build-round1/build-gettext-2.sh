#!/bin/bash

export SOURCE="gettext-0.18.3.2"

[ -d ${SOURCE} ] & rm -rf ${SOURCE}

tar -zxf ../sources/gettext-0.18.3.2.tar.gz

cd ${SOURCE}
cd gettext-tools
EMACS="no" ./configure --prefix=/tools --disable-shared
make -C gnulib-lib
make -C src msgfmt
make -C src msgmerge
make -C src xgettext
cp -v src/{msgfmt,msgmerge,xgettext} /tools/bin

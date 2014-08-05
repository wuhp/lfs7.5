#!/bin/bash

export SOURCE="perl-5.18.2"

[ -d ${SOURCE} ] & rm -rf ${SOURCE}

tar -jxf ../sources/perl-5.18.2.tar.bz2

cd ${SOURCE}
patch -Np1 -i ../../sources/perl-5.18.2-libc-1.patch
sh Configure -des -Dprefix=/tools
make
cp -v perl cpan/podlators/pod2man /tools/bin
mkdir -pv /tools/lib/perl5/5.18.2
cp -Rv lib/* /tools/lib/perl5/5.18.2

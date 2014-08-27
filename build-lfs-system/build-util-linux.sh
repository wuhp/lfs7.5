#!/bin/bash

export SOURCE="util-linux-2.24.1"

[ -d ${SOURCE} ] & rm -rf ${SOURCE}

tar -Jxf ../sources/util-linux-2.24.1.tar.xz

cd ${SOURCE}
sed -i -e 's@etc/adjtime@var/lib/hwclock/adjtime@g' \
          $(grep -rl '/etc/adjtime' .)

mkdir -pv /var/lib/hwclock

./configure
make
make install

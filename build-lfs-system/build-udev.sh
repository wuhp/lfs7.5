#!/bin/bash

export SOURCE="systemd-208"

[ -d ${SOURCE} ] & rm -rf ${SOURCE}

tar -Jxf ../sources/systemd-208.tar.xz

cd ${SOURCE}
tar -xvf ../../sources/udev-lfs-208-3.tar.bz2
ln -svf /tools/include/blkid /usr/include
ln -svf /tools/include/uuid  /usr/include
export LD_LIBRARY_PATH=/tools/lib

make -f udev-lfs-208-3/Makefile.lfs
make -f udev-lfs-208-3/Makefile.lfs install

build/udevadm hwdb --update
bash udev-lfs-208-3/init-net-rules.sh
rm -fv /usr/include/{uuid,blkid}
unset LD_LIBRARY_PATH

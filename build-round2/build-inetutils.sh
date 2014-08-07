#!/bin/bash

export SOURCE="inetutils-1.9.2"

[ -d ${SOURCE} ] & rm -rf ${SOURCE}

tar -zxf ../sources/inetutils-1.9.2.tar.gz

cd ${SOURCE}
echo '#define PATH_PROCNET_DEV "/proc/net/dev"' >> ifconfig/system/linux.h 
./configure --prefix=/usr  \
    --localstatedir=/var   \
    --disable-logger       \
    --disable-syslogd      \
    --disable-whois        \
    --disable-servers

make
# make check
make install

mv -v /usr/bin/{hostname,ping,ping6,traceroute} /bin
mv -v /usr/bin/ifconfig /sbin


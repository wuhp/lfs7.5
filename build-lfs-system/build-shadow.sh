#!/bin/bash

export SOURCE="shadow-4.1.5.1"

[ -d ${SOURCE} ] & rm -rf ${SOURCE}

tar -zxf ../sources/shadow_4.1.5.1.orig.tar.gz

cd ${SOURCE}

sed -i 's/groups$(EXEEXT) //' src/Makefile.in
find man -name Makefile.in -exec sed -i 's/groups\.1 / /' {} \;

sed -i -e 's@#ENCRYPT_METHOD DES@ENCRYPT_METHOD SHA512@' \
       -e 's@/var/spool/mail@/var/mail@' etc/login.defs

# If you chose to build Shadow with Cracklib support, run the following:
# sed -i 's@DICTPATH.*@DICTPATH\t/lib/cracklib/pw_dict@' etc/login.defs

./configure --sysconfdir=/etc
make
make install

mv -v /usr/bin/passwd /bin

### Configuring
pwconv
grpconv
sed -i 's/yes/no/' /etc/default/useradd


### Setting the root password
# Choose a password for user root and set it by running:
# passwd root


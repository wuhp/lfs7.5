#!/bin/bash

export SOURCE="sysklogd-1.5"

[ -d ${SOURCE} ] & rm -rf ${SOURCE}

tar -zxf ../sources/sysklogd-1.5.tar.gz

cd ${SOURCE}
make
make BINDIR=/sbin install

### Configuring sysklogd
cat > /etc/syslog.conf << "EOF"
# Begin /etc/syslog.conf

auth,authpriv.* -/var/log/auth.log
*.*;auth,authpriv.none -/var/log/sys.log
daemon.* -/var/log/daemon.log
kern.* -/var/log/kern.log
mail.* -/var/log/mail.log
user.* -/var/log/user.log
*.emerg *

# End /etc/syslog.conf
EOF

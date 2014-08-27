#!/bin/bash

export SOURCE="flex-2.5.38"

[ -d ${SOURCE} ] & rm -rf ${SOURCE}

tar -jxf ../sources/flex-2.5.38.tar.bz2

cd ${SOURCE}
sed -i -e '/test-bison/d' tests/Makefile.in
./configure --prefix=/usr --docdir=/usr/share/doc/flex-2.5.38

make
#make check
make install

cat > /usr/bin/lex << "EOF"
#!/bin/sh
# Begin /usr/bin/lex

exec /usr/bin/flex -l "$@"

# End /usr/bin/lex
EOF
chmod -v 755 /usr/bin/lex


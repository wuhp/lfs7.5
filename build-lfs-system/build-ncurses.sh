#!/bin/bash

export SOURCE="ncurses-5.9"

[ -d ${SOURCE} ] & rm -rf ${SOURCE}

tar -zxf ../sources/ncurses-5.9.tar.gz

cd ${SOURCE}
./configure --prefix=/usr           \
            --mandir=/usr/share/man \
            --with-shared           \
            --without-debug         \
            --enable-pc-files       \
            --enable-widec
make
make install

mv -v /usr/lib/libncursesw.so.5* /lib
ln -sfv ../../lib/$(readlink /usr/lib/libncursesw.so) /usr/lib/libncursesw.so

for lib in ncurses form panel menu ; do
    rm -vf                    /usr/lib/lib${lib}.so
    echo "INPUT(-l${lib}w)" > /usr/lib/lib${lib}.so
    ln -sfv lib${lib}w.a      /usr/lib/lib${lib}.a
    ln -sfv ${lib}w.pc        /usr/lib/pkgconfig/${lib}.pc
done

ln -sfv libncurses++w.a /usr/lib/libncurses++.a

rm -vf                     /usr/lib/libcursesw.so
echo "INPUT(-lncursesw)" > /usr/lib/libcursesw.so
ln -sfv libncurses.so      /usr/lib/libcurses.so
ln -sfv libncursesw.a      /usr/lib/libcursesw.a
ln -sfv libncurses.a       /usr/lib/libcurses.a

mkdir -v       /usr/share/doc/ncurses-5.9
cp -v -R doc/* /usr/share/doc/ncurses-5.9

# The instructions above don't create non-wide-character 
# Ncurses libraries since no package installed by compiling 
# from sources would link against them at runtime. If you must 
# have such libraries because of some binary-only application 
# or to be compliant with LSB, build the package again with the 
# following commands:

# make distclean
# ./configure --prefix=/usr    \
#             --with-shared    \
#             --without-normal \
#             --without-debug  \
#             --without-cxx-binding
# make sources libs
# cp -av lib/lib*.so.5* /usr/lib

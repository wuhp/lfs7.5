#!/bin/bash

export SOURCE="gcc-4.8.2"
export BUILD="gcc-build-1"

[ -d ${SOURCE} ] & rm -rf ${SOURCE}
[ -d ${BUILD} ] & rm -rf ${BUILD}

tar -jxf ../sources/gcc-4.8.2.tar.bz2

cd ${SOURCE}

tar -Jxf ../../sources/mpfr-3.1.2.tar.xz
mv -v mpfr-3.1.2 mpfr
tar -Jxf ../../sources/gmp-5.1.3.tar.xz
mv -v gmp-5.1.3 gmp
tar -zxf ../../sources/mpc-1.0.2.tar.gz
mv -v mpc-1.0.2 mpc

for file in \
 $(find gcc/config -name linux64.h -o -name linux.h -o -name sysv4.h)
do
  cp -uv $file{,.orig}
  sed -e 's@/lib\(64\)\?\(32\)\?/ld@/tools&@g' \
      -e 's@/usr@/tools@g' $file.orig > $file
  echo '
#undef STANDARD_STARTFILE_PREFIX_1
#undef STANDARD_STARTFILE_PREFIX_2
#define STANDARD_STARTFILE_PREFIX_1 "/tools/lib/"
#define STANDARD_STARTFILE_PREFIX_2 ""' >> $file
  touch $file.orig
done

sed -i '/k prot/agcc_cv_libc_provides_ssp=yes' gcc/configure

cd ..

mkdir -p ${BUILD}
cd ${BUILD}
../${SOURCE}/configure     \
    --target=$LFS_TGT                                \
    --prefix=/tools                                  \
    --with-sysroot=$LFS                              \
    --with-newlib                                    \
    --without-headers                                \
    --with-local-prefix=/tools                       \
    --with-native-system-header-dir=/tools/include   \
    --disable-nls                                    \
    --disable-shared                                 \
    --disable-multilib                               \
    --disable-decimal-float                          \
    --disable-threads                                \
    --disable-libatomic                              \
    --disable-libgomp                                \
    --disable-libitm                                 \
    --disable-libmudflap                             \
    --disable-libquadmath                            \
    --disable-libsanitizer                           \
    --disable-libssp                                 \
    --disable-libstdc++-v3                           \
    --enable-languages=c,c++                         \
    --with-mpfr-include=$(pwd)/../${SOURCE}/mpfr/src \
    --with-mpfr-lib=$(pwd)/mpfr/src/.libs
make
make install

cd `$LFS_TGT-gcc -print-libgcc-file-name | xargs dirname`
ln -sv libgcc.a libgcc_eh.a
cd -

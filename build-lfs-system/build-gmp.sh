#!/bin/bash

export SOURCE="gmp-5.1.3"

[ -d ${SOURCE} ] & rm -rf ${SOURCE}

tar -Jxf ../sources/gmp-5.1.3.tar.xz

cd ${SOURCE}

# If you are building for 32-bit x86, but you have a CPU 
# which is capable of running 64-bit code and you have specified 
# CFLAGS in the environment, the configure script will attempt 
# to configure for 64-bits and fail. Avoid this by invoking the 
# configure command below with
# ABI=32 ./configure ...

./configure --prefix=/usr --enable-cxx
make

#make check 2>&1 | tee gmp-check-log
#awk '/tests passed/{total+=$2} ; END{print total}' gmp-check-log
make install

mkdir -v /usr/share/doc/gmp-5.1.3
cp    -v doc/{isa_abi_headache,configuration} doc/*.html \
         /usr/share/doc/gmp-5.1.3


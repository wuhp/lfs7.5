#!/bin/bash

./build-binutils-1.sh
./build-gcc-1.sh
./build-linux-header-1.sh
./build-glibc-1.sh
./test1.sh
./build-libstdc++-v3-1.sh

./build-binutils-2.sh
./build-gcc-2.sh
./test2.sh

./build-tcl-2.sh 
./build-expect-2.sh 
./build-dejagnu-2.sh 
./build-check-2.sh
./build-ncurses-2.sh 
./build-bash-2.sh 
./build-bzip-2.sh 
./build-coreutils-2.sh 
./build-diffutils-2.sh 
./build-file-2.sh 
./build-findutils-2.sh 
./build-gawk-2.sh 
./build-gettext-2.sh 
./build-grep-2.sh 
./build-gzip-2.sh 
./build-m4-2.sh 
./build-make-2.sh 
./build-patch-2.sh 
./build-perl-2.sh 
./build-sed-2.sh 
./build-tar-2.sh 
./build-texinfo-2.sh 
./build-util-linux-2.sh 
./build-xz-2.sh 

#!/bin/bash

./build-linux-header.sh
./build-man-pages.sh
./build-glibc.sh
./adjust-toolchain.sh
./build-zlib.sh 
./build-file.sh 

./test1.sh

./build-binutils.sh
./build-gmp.sh
./build-mpfr.sh
./build-mpc.sh
./build-gcc.sh

./test2.sh

./build-sed.sh 
./build-bzip2.sh 
./build-pkg-config.sh 
./build-ncurses.sh 
./build-shadow.sh 
./build-psmisc.sh 
./build-procps-ng.sh 
./build-e2fsprogs.sh 
./build-coreutils.sh 
./build-iana-etc.sh 
./build-m4.sh 
./build-flex.sh 
./build-bison.sh
./build-grep.sh 
./build-readline.sh 
./build-bash.sh 
./build-bc.sh 
./build-libtool.sh 
./build-gdbm.sh 
./build-inetutils.sh 
./build-perl.sh 
./build-autoconf.sh 
./build-automake.sh 
./build-diffutils.sh 
./build-gawk.sh 
./build-findutils.sh 
./build-gettext.sh 
./build-groff.sh 
./build-xz.sh 
./build-grub.sh 
./build-less.sh 
./build-gzip.sh 
./build-iproute2.sh 
./build-kbd.sh 
./build-kmod.sh 
./build-libpipeline.sh 
./build-make.sh 
./build-patch.sh
./build-sysklogd.sh 
./build-sysvinit.sh 
./build-tar.sh 
./build-texinfo.sh 
./build-udev.sh 
./build-util-linux.sh 
./build-man-db.sh 
./build-vim.sh 

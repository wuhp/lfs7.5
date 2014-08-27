#!/bin/bash

mv -v /tools/bin/{ld,ld-old}
mv -v /tools/$(gcc -dumpmachine)/bin/{ld,ld-old}
mv -v /tools/bin/{ld-new,ld}
ln -sv /tools/bin/ld /tools/$(gcc -dumpmachine)/bin/ld

gcc -dumpspecs | sed -e 's@/tools@@g'                   \
    -e '/\*startfile_prefix_spec:/{n;s@.*@/usr/lib/ @}' \
    -e '/\*cpp:/{n;s@$@ -isystem /usr/include@}' >      \
    `dirname $(gcc --print-libgcc-file-name)`/specs

# test1
echo 'main(){}' > dummy.c
cc dummy.c -v -Wl,--verbose &> dummy.log
readelf -l a.out | grep ': /lib'

# test2
grep -o '/usr/lib.*/crt[1in].*succeeded' dummy.log

# test3
grep -B1 '^ /usr/include' dummy.log

# test4
grep 'SEARCH.*/usr/lib' dummy.log |sed 's|; |\n|g'

# test5
grep "/lib.*/libc.so.6 " dummy.log

# test6
grep found dummy.log

rm -v dummy.c a.out dummy.log

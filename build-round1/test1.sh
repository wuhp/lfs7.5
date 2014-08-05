#!/bin/bash
cd /tmp
echo 'main(){}' > dummy.c
$LFS_TGT-gcc dummy.c
readelf -l a.out | grep ': /tools' > /dev/null

if [ $? -eq 0 ]; then
  echo "TEST1    [   OK   ]"
else
  echo "TEST1    [ Failed ]"
fi



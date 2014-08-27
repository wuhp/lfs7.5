#!/bin/bash
cd /tmp
echo 'main(){}' > dummy.c
cc dummy.c
readelf -l a.out | grep ': /tools' > /dev/null

if [ $? -eq 0 ]; then
  echo "TEST2    [   OK   ]"
else
  echo "TEST2    [ Failed ]"
fi



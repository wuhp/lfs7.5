#!/bin/bash

expect -c "spawn ls" | grep "spawn ls"
if [ $? -eq 0 ]; then
  echo "TEST1  [   OK   ]"
else
  echo "TEST1  [ Failed ]"
fi

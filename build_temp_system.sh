#!/bin/bash

rm -rf ${LFS}/build/*
cp build-temp-system/*.sh ${LFS}/build/

. env.def
cd ${LFS}/build/
./build.sh


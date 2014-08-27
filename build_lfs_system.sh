#!/bin/bash

rm -rf ${LFS}/build/*
cp build-lfs-system/*.sh ${LFS}/build/

. env.def

cd /build
./build.sh


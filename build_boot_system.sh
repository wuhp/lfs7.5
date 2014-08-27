#!/bin/bash

rm -rf ${LFS}/build/*
cp build-boot-system/*.sh ${LFS}/build/

. env.def

cd /build
./build.sh


#!/bin/bash

# Changing permission
chown -R root:root $LFS/tools
chown -R root:root $LFS/build
chown -R root:root $LFS/sources

# Copying build scripts
cp -r build-round2/* /build

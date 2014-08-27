#!/bin/bash

echo ${LFS_RELEASE_VERSION} > /etc/lfs-release

cat > /etc/lsb-release << EOF
DISTRIB_ID=${LFS_DISTRIB_ID}
DISTRIB_RELEASE=${LFS_RELEASE_VERSION}
DISTRIB_CODENAME=${LFS_DISTRIB_CODENAME}
DISTRIB_DESCRIPTION=${LFS_DISTRIB_DESCRIPTION}
EOF

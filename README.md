lfs7.5
======

Create a linux distribution, following instructions on LFS 7.5
All the scripts in this repo should be run on Ubuntu 12.04 x86, and the new created linux
distribution is based on x86 system.

### Preparation ###
# root #

apt-get install openssh-server
apt-get update
apt-get upgrade
apt-get install vim curl tree

### Below package will be used during LFS building
apt-get install build-essential
apt-get install gawk
apt-get install bison
apt-get install flex
apt-get install byacc

### Create partition
# Add an 20G SCSI hard disk
# /dev/sdb

fdisk -l
fdisk /dev/sdb
# create primary partition /dev/sdb1
mkfs -v -t ext4 /dev/sdb1

### Env setup
cat > ~/.bashrc << "EOF"
export LFS=/mnt/lfs
export PS1='[\u@\h:\W]$ '
EOF

mkdir ${LFS}
mount /dev/sdb1 ${LFS}

mkdir ${LFS}/tools
mkdir ${LFS}/sources
mkdir ${LFS}/build

ln -sv ${LFS}/tools /

groupadd lfs
useradd -s /bin/bash -g lfs -m -k /dev/null lfs
passwd lfs  ### lfs

chown -v lfs ${LFS}/tools
chown -v lfs ${LFS}/sources
chown -v lfs ${LFS}/build

### Download sources
cd ~
wget http://www.linuxfromscratch.org/lfs/downloads/7.5/wget-list
wget -i wget-list -P ${LFS}/sources

----------------------------------------------------------------------

# lfs #

cat > ~/.bash_profile << "EOF"
exec env -i HOME=$HOME TERM=$TERM PS1='[\u@\h:\W]$ ' /bin/bash
EOF

cat > ~/.bashrc << "EOF"
set +h
umask 022
LFS=/mnt/lfs
LC_ALL=POSIX
LFS_TGT=$(uname -m)-lfs-linux-gnu
PATH=/tools/bin:/bin:/usr/bin
export LFS LC_ALL LFS_TGT PATH
export PS1='[\u@\h:\W]$ '
EOF

### Build Round 1 ###
### re-login as lfs
env
echo $LFS
echo $LFS_TGT

./build.sh

### Build Round 2 ###

./build_lfs_system_0.sh
./build_lfs_system_1.sh

chroot "$LFS" /tools/bin/env -i \
    HOME=/root                  \
    TERM="$TERM"                \
    PS1='\u:\w\$ '              \
    PATH=/bin:/usr/bin:/sbin:/usr/sbin:/tools/bin \
    /tools/bin/bash --login +h

./build_lfs_system_2.sh

# To remove the “I have no name!” prompt, start a new shell.
exec /tools/bin/bash --login +h

./build_lfs_system_3.sh

rm -rf /build/* /tmp/*

### Setup boot system ###

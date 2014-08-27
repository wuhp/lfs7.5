lfs7.5
======

Create a linux distribution, following instructions on LFS 7.5.

All the steps done in this README are tested in below environment.
1. Host machine is virtual machine in VMware Fusion 4.1.4
2. Host machine is Ubuntu 12.04 x86
3. New target linux distribution(LFS) is run on x86 system
4. New target linux distribution(LFS) is built on an additional hard disk(SCSI)

### Preparation ###

# Following commands are assumed to be run as root
$ su -

# Fetch build scripts
git clone https://github.com/wuhp/lfs7.5.git

# Set env for root
$ echo "export LFS=/mnt/lfs"  >> ~/.bashrc
$ bash

# Install necessary packages which will be used during LFS building
$ apt-get install -y curl build-essential gawk bison flex byacc

# Create disk and partition
1) Shutdown the host vm
2) Add an 20G SCSI hard disk
     Virtual Machine --> Settings --> Add device --> New Hard Disk
3) Power on the host vm, login as root
4) Run command below to check if the new hard disk is added, usually it will be "/dev/sdb"
     fdisk -l

$ fdisk /dev/sdb
Command (m for help): n
Select (default p):
Partition number (1-4, default 1):
First sector (2048-41943039, default 2048):
Last sector, +sectors or +size{K,M,G} (2048-41943039, default 41943039):
Command (m for help): w

# Format partition
$ mkfs -v -t ext4 /dev/sdb1

# Create a new user to build LFS
$ groupadd lfs
$ useradd -s /bin/bash -g lfs -m -k /dev/null lfs
$ passwd lfs

# Setup build file system
$ mkdir -p ${LFS}
$ mount /dev/sdb1 ${LFS}
$ mkdir ${LFS}/tools
$ mkdir ${LFS}/sources
$ mkdir ${LFS}/build
$ mkdir ${LFS}/workspace
$ ln -sv ${LFS}/tools /

# Change build system owner to lfs
$ chown -v lfs ${LFS}/tools
$ chown -v lfs ${LFS}/sources
$ chown -v lfs ${LFS}/build
$ chown -v lfs ${LFS}/workspace

# Download source files and copy build script
$ wget -i lfs7.5/resource/wget-list -P ${LFS}/sources
$ [ -d ${LFS}/workspace/lfs7.5 ] || cp -r lfs7.5 ${LFS}/workspace/lfs7.5

# Set env for lfs
$ su - lfs

$ cat > ~/.bash_profile << EOF
exec env -i HOME=$HOME TERM=$TERM /bin/bash
EOF

$ cat > ~/.bashrc << EOF
set +h
umask 022
LFS=/mnt/lfs
LC_ALL=POSIX
LFS_TGT=$(uname -m)-lfs-linux-gnu
PATH=/tools/bin:/bin:/usr/bin
export LFS LC_ALL LFS_TGT PATH
EOF

### Constructing a Temporary System ###
cd ${LFS}/workspace/lfs7.5
./build_temp_system.sh

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

cp build-round3/* /build/
cd /build
./build.sh

tar -Jxf ../sources/linux-3.13.3.tar.xz
cd linux-3.13.3
make mrproper

# Tips on kernel configuration
# 1. Disable 64-bit kernel
#   64-bit kernel
# 2. Enable fusion MPT scsi support
#   Device Drivers  --->
#     Fusion MPT device support --->
#       Fusion MPT ScsiHost drivers for SPI
#       Fusion MPT misc device (ioctl) driver
# 3. Support recent changes in udev, enable devtmpfs
#   Device Drivers  --->
#     Generic Driver Options  --->
#       Maintain a devtmpfs filesystem to mount at /dev
# 4. Enable PCnet32 PCI support
#   Device Drivers  --->
#     Network device support  --->
#       Ethernet driver support  --->
#         AMD devices  --->
#           AMD PCnet32 PCI support
# 5. Every item which needs to be built should be kernel built-in in ".config", should not be module, since we don't use initramdisk when booting
#   sed -i "s/=m/=y/g" .config

# An config example for building kernel, "example_kernel.config"
make LANG=C LC_ALL= menuconfig
make
make modules_install

cp -v arch/x86/boot/bzImage /boot/vmlinuz-3.13.3-lfs-7.5
cp -v System.map /boot/System.map-3.13.3
cp -v .config /boot/config-3.13.3
install -d /usr/share/doc/linux-3.13.3
cp -r Documentation/* /usr/share/doc/linux-3.13.4

install -v -m755 -d /etc/modprobe.d
cat > /etc/modprobe.d/usb.conf << "EOF"
# Begin /etc/modprobe.d/usb.conf

install ohci_hcd /sbin/modprobe ehci_hcd ; /sbin/modprobe -i ohci_hcd ; true
install uhci_hcd /sbin/modprobe ehci_hcd ; /sbin/modprobe -i uhci_hcd ; true

# End /etc/modprobe.d/usb.conf
EOF

echo 7.5 > /etc/lfs-release

cat > /etc/lsb-release << "EOF"
DISTRIB_ID="Linux From Scratch"
DISTRIB_RELEASE="7.5"
DISTRIB_CODENAME="wuhp"
DISTRIB_DESCRIPTION="Linux From Scratch"
EOF

### Boot lfs ###

reboot
# enter grub cmd line
ls
set root=(xx,xx)
linux /boot/vmlinuz-3.13.3-lfs-7.5 root=/dev/sdb1
boot

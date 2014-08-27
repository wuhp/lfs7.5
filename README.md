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
$ git clone https://github.com/wuhp/lfs7.5.git

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
$ su - lfs

$ cd ${LFS}/workspace/lfs7.5
$ ./build_temp_system.sh


### Building the LFS System ###
$ su - 

# Change owner back to root
$ chown -R root:root $LFS/tools
$ chown -R root:root $LFS/build
$ chown -R root:root $LFS/sources
$ chown -R root:root $LFS/workspace

# Env setup in host vm 
$ cd ${LFS}/workspace/lfs7.5
$ ./build_lfs_system__host_setup.sh

# Chroot to lfs system
$ chroot "$LFS" /tools/bin/env -i \
    HOME=/root                    \
    TERM="$TERM"                  \
    PS1='\u:\w\$ '                \
    PATH=/bin:/usr/bin:/sbin:/usr/sbin:/tools/bin \
    /tools/bin/bash --login +h

# Env setup in lfs system
$ cd /workspace/lfs7.5
$ ./build_lfs_system__lfs_setup.sh
$ exec /tools/bin/bash --login +h

# Start lfs build
$ cd /workspace/lfs7.5
$ ./build_lfs_system.sh


### Setup boot system ###

# Configure boot system
$ cd /workspace/lfs7.5
$ ./build_boot_system.sh

# Build & install linux kernel
$ cd /build
$ tar -Jxf ../sources/linux-3.13.3.tar.xz
$ cd linux-3.13.3
$ make mrproper

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

# An example of kernel config file is located in git repo, named "example_kernel.config"
$ make LANG=C LC_ALL= menuconfig
$ make
$ make modules_install

$ cp -v arch/x86/boot/bzImage /boot/vmlinuz-3.13.3-lfs-7.5
$ cp -v System.map /boot/System.map-3.13.3
$ cp -v .config /boot/config-3.13.3
$ install -d /usr/share/doc/linux-3.13.3
$ cp -r Documentation/* /usr/share/doc/linux-3.13.4

$ install -v -m755 -d /etc/modprobe.d
$ cat > /etc/modprobe.d/usb.conf << "EOF"
install ohci_hcd /sbin/modprobe ehci_hcd ; /sbin/modprobe -i ohci_hcd ; true
install uhci_hcd /sbin/modprobe ehci_hcd ; /sbin/modprobe -i uhci_hcd ; true
EOF


### Boot LFS system ###

$ reboot

# Enter grub cmd line
set root=(hd1,xx)
linux /boot/vmlinuz-3.13.3-lfs-7.5 root=/dev/sdb1 ro
boot

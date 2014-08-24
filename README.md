lfs7.5
======

Create a linux distribution, following instructions on LFS 7.5.

All the steps done in this README are tested in ubuntu 12.04 x86.

1. The host Ubuntu 12.04 is a vm created in VMware Fusion
2. The target new linux distribution(LFS) is also based on x86 system

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

cp build-round3/* /build/
cd /build
./build.sh

tar -Jxf ../sources/linux-3.13.3.tar.xz
cd linux-3.13.3
make mrproper

# Tips on kernel configuration
# 1. disable 64-bit kernel
#   64-bit kernel
# 2. enable fusion MPT scsi support
#   Device Drivers  --->
#     Fusion MPT device support --->
#       Fusion MPT ScsiHost drivers for SPI
# 3. support recent changes in udev
#   Device Drivers  --->
#     Generic Driver Options  --->
#       Maintain a devtmpfs filesystem to mount at /dev
# 4. Every item in compile config should be kernel built-in, not module, since we don't use initramdisk when booting

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

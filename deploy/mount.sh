ROOTFS_DIR=rpi_mnt
TARGET=raspbian-jessie-lite.img

losetup -D
losetup -f -P --show ${TARGET} 
mount /dev/loop0p2 -o rw ${ROOTFS_DIR}



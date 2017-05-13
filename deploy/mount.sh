ROOTFS_DIR=rpi_mnt
TARGET=raspbian-jessie-lite.img

losetup -D
LOOP_DEVICE=$(losetup -f -P --show ${TARGET})p2
mount ${LOOP_DEVICE} -o rw ${ROOTFS_DIR}



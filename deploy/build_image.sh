ROOTFS_DIR=rpi_mnt
SOURCE=2017-04-10-raspbian-jessie-lite.img
TARGET=raspbian-jessie-lite.img

on_chroot() {
        if ! mount | grep -q "$(realpath "${ROOTFS_DIR}"/proc)"; then
                mount -t proc proc "${ROOTFS_DIR}/proc"
        fi

        if ! mount | grep -q "$(realpath "${ROOTFS_DIR}"/dev)"; then
                mount --bind /dev "${ROOTFS_DIR}/dev"
        fi

        if ! mount | grep -q "$(realpath "${ROOTFS_DIR}"/dev/pts)"; then
                mount --bind /dev/pts "${ROOTFS_DIR}/dev/pts"
        fi

        if ! mount | grep -q "$(realpath "${ROOTFS_DIR}"/sys)"; then
                mount --bind /sys "${ROOTFS_DIR}/sys"
        fi

        capsh --drop=cap_setfcap "--chroot=${ROOTFS_DIR}/" -- "$@"
}

unmount(){
        if [ -z "$1" ]; then
                DIR=$PWD
        else
                DIR=$1
        fi

        while mount | grep -q "$DIR"; do
                local LOCS
                LOCS=$(mount | grep "$DIR" | cut -f 3 -d ' ' | sort -r)
                for loc in $LOCS; do
                        umount "$loc"
                done
        done
}

unmount ${ROOTFS_DIR}

cp ${SOURCE} ${TARGET}
mkdir -p ${ROOTFS_DIR}
losetup -D
LOOP_DEVICE=$(losetup -f -P --show ${TARGET})p2
mount ${LOOP_DEVICE} -o rw ${ROOTFS_DIR}

if [ -e ${ROOTFS_DIR}/etc/ld.so.preload ]; then
        mv ${ROOTFS_DIR}/etc/ld.so.preload ${ROOTFS_DIR}/etc/ld.so.preload.disabled
fi

if [ ! -x ${ROOTFS_DIR}/usr/bin/qemu-arm-static ]; then
        cp /usr/bin/qemu-arm-static ${ROOTFS_DIR}/usr/bin/
fi


#Install hello
mkdir -p ${ROOTFS_DIR}/usr/lib/systemd/system/
cp config/systemd/hello.service  ${ROOTFS_DIR}/usr/lib/systemd/system/hello.service
mkdir -p ${ROOTFS_DIR}/opt/hello/
cp -r ../hello/* ${ROOTFS_DIR}/opt/hello/


on_chroot < instructions.sh

#Setup nginx config
cp config/nginx/default ${ROOTFS_DIR}/etc/nginx/sites-available/default

#Setup wlan0 config
cp config/network/interfaces ${ROOTFS_DIR}/etc/network/interfaces

#Setup hostapd config
mkdir -p ${ROOTFS_DIR}/etc/hostapd
cp config/hostapd/hostapd.conf ${ROOTFS_DIR}/etc/hostapd/hostapd.conf
sed -i 's^#DAEMON_CONF=""^DAEMON_CONF=/etc/hostapd/hostapd.conf^g' ${ROOTFS_DIR}/etc/default/hostapd

#Setup dnsmasq config
cp config/dnsmasq/dnsmasq.conf ${ROOTFS_DIR}/etc/dnsmasq.conf

#Make journald persist between boots
mkdir -p ${ROOTFS_DIR}/var/log/journal

rm -f ${ROOTFS_DIR}/usr/bin/qemu-arm-static
rm -f ${ROOTFS_DIR}/etc/apt/apt.conf.d/51cache
if [ -e ${ROOTFS_DIR}/etc/ld.so.preload.disabled ]; then
        mv ${ROOTFS_DIR}/etc/ld.so.preload.disabled ${ROOTFS_DIR}/etc/ld.so.preload
fi

unmount ${ROOTFS_DIR}

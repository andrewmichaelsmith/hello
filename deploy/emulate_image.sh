qemu-img convert -f raw -O qcow2  raspbian-jessie-lite.img raspbian-jessie-lite.qcow
qemu-img resize raspbian-jessie-lite.qcow +6G

sudo guestmount -a raspbian-jessie-lite.qcow -m /dev/sda2 /pi
echo "" > /pi/etc/ld.so.preload
sudo umount /pi

qemu-system-arm -kernel kernel-qemu \
                  -no-reboot \
                  -nographic \
                  -cpu arm1176 \
                  -m 256 \
                  -M versatilepb \
                  -no-reboot \
                  -append "root=/dev/sda2 panic=1 rootfstype=ext4 rw console=ttyAMA0,115200 " \
                  -hda raspbian-jessie-lite.qcow


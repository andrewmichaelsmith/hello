mkdir -p sd_mnt
sudo mount  /dev/sdc2 sd_mnt 
mv sd_mnt/etc/ld.so.preload sd_mnt/etc/ld.so.preload.disabled
sudo umount sd_mnt/

echo "I have damaged your SD card!"

qemu-system-arm -kernel kernel-qemu \
                  -no-reboot \
                  -nographic \
                  -cpu arm1176 \
                  -m 256 \
                  -M versatilepb \
                  -no-reboot \
                  -append "root=/dev/sda2 panic=1 rootfstype=ext4 rw console=ttyAMA0,115200 " \
                  -hda /dev/sdc


sudo mount  /dev/sdc2 sd_mnt 
mv sd_mnt/etc/ld.so.preload.disabled sd_mnt/etc/ld.so.preload
sudo umount sd_mnt/



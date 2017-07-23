Scripts to build a raspberry pi image with our hello code

The intention is to add to the base raspberry pi image (at
time of writing this is 2017-07-05-raspbian-jessie-lite.img)

Dependencies:

 * qemu-arm-static

Setup:

```
wget https://downloads.raspberrypi.org/raspbian_lite/images/raspbian_lite-2017-07-05/2017-07-05-raspbian-jessie-lite.zip
unzip 2017-07-05-raspbian-jessie-lite.zip
sudo sh build_image.sh
```

Emulation:

You can run the image with qemu (need to use this kernel)

```
wget https://github.com/dhruvvyas90/qemu-rpi-kernel/blob/master/kernel-qemu-4.4.34-jessie?raw=true
mv kernel-qemu-4.4.34-jessie?raw=true kernel-qemu
sudo sh emulate_image.sh
```

Write to SD:

```
sudo dd bs=4M if=raspbian-jessie-lite.img of=/dev/sdc
```

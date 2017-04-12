Scripts to build a raspberry pi image with our hello code

The intention is to add to the base raspberry pi image (at
time of writing this is 2017-04-10-raspbian-jessie-lite.img)

Dependencies:

 * qemu-arm-static

Setup:

 wget https://downloads.raspberrypi.org/raspbian_lite/images/raspbian_lite-2017-04-10/2017-04-10-raspbian-jessie-lite.zip
 unzip unzip 2017-04-10-raspbian-jessie-lite.zip
 build_image.sh

Emulation:

You can run the image with qemu 

  wget https://github.com/dhruvvyas90/qemu-rpi-kernel/blob/master/kernel-qemu-4.4.34-jessie?raw=true
  mv kernel-qemu-4.4.34-jessie?raw=true kernel-qemu
  emulate_image.sh


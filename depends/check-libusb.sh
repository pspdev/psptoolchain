#!/bin/sh
# check-libusb.sh by take-cheeze (takechi101010@gmail.com)

 ls /usr/include/usb.h 1> /dev/null || \
 ls /usr/local/include/usb.h 1> /dev/null || \
 ls /opt/local/include/usb.h 1> /dev/null || \
  { echo "ERROR: Install libusb before continuing."; exit 1; }

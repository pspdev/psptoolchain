#!/bin/sh
# check-libusb.sh by take-cheeze (takechi101010@gmail.com)

ls /usr/include/usb.h > /dev/null 2>&1 || \
ls /usr/local/include/usb.h > /dev/null 2>&1 || \
ls /opt/local/include/usb.h > /dev/null 2>&1 || \
{ echo "ERROR: Install libusb before continuing."; exit 1; }


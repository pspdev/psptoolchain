#!/bin/bash

# `cd` into the toolchain directory, to be able to use relative paths
cd $(dirname $0)

# Install build dependencies
sudo apt-get install $@ g++ build-essential autoconf automake automake1.9 cmake doxygen bison flex libncurses5-dev libsdl1.2-dev libreadline-dev libusb-dev texinfo libgmp3-dev libmpfr-dev libelf-dev libmpc-dev libfreetype6-dev zlib1g-dev libtool subversion git tcl unzip

# Make `/bin/sh` an alias for `/bin/bash` instead of `/bin/dash` - which is
# faster, but doesn't play nice with some autotools scripts in psp-ports.
# The `sudo true` is to make sure we don't pipe into a `sudo` password prompt
# instead of the intended program.
sudo true; echo "dash dash/sh boolean false" | sudo debconf-set-selections
sudo dpkg-reconfigure --frontend=noninteractive dash

# Make Type-B PSP devices (eg. PSPs running PSPLink) mount world-writable,
# removing the need to run usbhostfs_pc as root. See above for `sudo true`.
sudo true; sudo cp dist/99-psplink.rules /etc/udev/rules.d/99-psplink.rules

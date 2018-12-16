#!/bin/bash

# Install build dependencies
sudo apt-get install $@ g++ build-essential autoconf automake cmake doxygen bison flex libncurses5-dev libsdl1.2-dev libreadline-dev libusb-dev texinfo libgmp3-dev libmpfr-dev libelf-dev libmpc-dev libfreetype6-dev zlib1g-dev libtool libtool-bin subversion git tcl unzip bzip2 gzip xz-utils

# Make `/bin/sh` an alias for `/bin/bash` instead of `/bin/dash` - which is
# faster, but doesn't play nice with some autotools scripts in psp-ports.
# The `sudo true` is to make sure we don't pipe into a `sudo` password prompt
# instead of the intended program.
sudo true; echo "dash dash/sh boolean false" | sudo debconf-set-selections
sudo dpkg-reconfigure --frontend=noninteractive dash

#!/bin/bash

# Install build dependencies
sudo apt-get install $@ \
  autoconf automake bison bzip2 cmake doxygen flex g++ gcc git gzip \
  libarchive-dev libcurl4-openssl-dev libelf-dev libgmp-dev libmpfr-dev \
  libncurses5-dev libreadline-dev libssl-dev libtool-bin libusb-dev make mpc \
  patch pkg-config python3 python3-venv subversion tar tcl texinfo unzip wget \
  xz-utils

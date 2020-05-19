#!/bin/bash

# Install build dependencies
sudo apt-get install $@ \
  autoconf automake bison bzip2 cmake doxygen flex gettext g++ gcc git gzip \
  libarchive-dev libcurl4-openssl-dev libelf-dev libgpgme-dev libncurses5-dev \
  libreadline-dev libssl-dev libtool-bin libusb-dev m4 make patch pkg-config \
  python3 python3-venv subversion tar tcl texinfo unzip wget xz-utils

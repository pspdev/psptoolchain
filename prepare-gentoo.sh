#!/bin/bash

# Install build dependencies
sudo emerge --newuse -uv $@ \
  autoconf automake bison bzip2 cmake doxygen flex gettext git gzip \
  libarchive curl libelf gpgme ncurses ncurses-compat \
  readline openssl openssl-compat libtool libusb libusb-compat m4 make patch \
  pkg-config subversion tar tcl texinfo unzip wget xz-utils

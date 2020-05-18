#!/bin/bash

# Install build dependencies
sudo dnf install $@ \
  autoconf automake bison bzip2 cmake doxygen diffutils flex g++ gcc git \
  gzip libarchive-devel libcurl-devel elfutils-libelf-devel gpgme-devel \
  openssl-devel libtool libusb-devel m4 make ncurses-devel patch pkgconf \
  python3 readline-devel subversion tar tcl texinfo unzip which wget xz

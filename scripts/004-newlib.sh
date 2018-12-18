#!/bin/bash
# newlib-1.20.0.sh by Naomi Peori (naomi@peori.ca)

. ../common.sh

# Exit on errors
set -e

NEWLIB_VERSION=1.20.0

# Download the source code if it does not already exist.
download_and_extract "https://sourceware.org/pub/newlib/newlib-$NEWLIB_VERSION.tar.gz" newlib-"$NEWLIB_VERSION"

# Enter the source directory and patch the source code.
cd newlib-"$NEWLIB_VERSION"
patch -p1 < ../../patches/newlib-"$NEWLIB_VERSION"-PSP.patch

# Create and enter the build directory.
mkdir build-psp
cd build-psp

# Configure the build.
../configure --prefix="$PSPDEV" --target="psp" \
	--enable-newlib-iconv \
	--enable-newlib-multithread \
	--enable-newlib-mb

## Compile and install.
run_make
run_make install
run_make clean

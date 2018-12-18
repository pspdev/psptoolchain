#!/bin/bash
# insight-6.8.sh by Naomi Peori (naomi@peori.ca)
exit;

. ../common.sh

# Exit on errors
set -e

INSIGHT_VERSION="6.8a"

# Download the source code if it does not already exist.
download_and_extract "https://sourceware.org/pub/insight/releases/insight-$INSIGHT_VERSION.tar.bz2" insight-"$INSIGHT_VERSION"

# Enter the source directory and patch the source code.
cd insight-"$INSIGHT_VERSION"
patch -p1 < ../../patches/insight-"$INSIGHT_VERSION"-PSP.patch

# Create and enter the build directory.
mkdir build-psp
cd build-psp

# Configure the build.
../configure --prefix="$PSPDEV" --target="psp" --disable-werror

# Compile and install.
run_make
run_make install
run_make clean

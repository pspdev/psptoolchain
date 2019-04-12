#!/bin/bash
# binutils-2.22.sh by Naomi Peori (naomi@peori.ca)

. ../common.sh

BINUTILS_VERSION=2.23.1

# Exit on errors
set -e

# Download the source code if it does not already exist.
download_and_extract https://ftp.gnu.org/pub/gnu/binutils/binutils-"$BINUTILS_VERSION".tar.bz2 binutils-"$BINUTILS_VERSION"

# Enter the source directory and patch the source code.
cd binutils-"$BINUTILS_VERSION"
patch -p1 < ../../patches/binutils-"$BINUTILS_VERSION"-PSP.patch

if [ -f ../patches/binutils-"$BINUTILS_VERSION"-fixes.patch ]
then
	patch -p1 < ../../patches/binutils-"$BINUTILS_VERSION"-fixes.patch
fi

# Create and enter the build directory.
mkdir build-psp
cd build-psp

# Configure the build.
../configure --prefix="$PSPDEV" --target="psp" --enable-install-libbfd --disable-werror --with-system-zlib

# Compile and install.
run_make 
run_make install
run_make clean

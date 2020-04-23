#!/bin/bash
# gdb-7.3.1.sh by Naomi Peori (naomi@peori.ca)

. ../common.sh

# Exit on errors
set -e

GDB_VERSION=7.5

# Download the source code if it does not already exist.
download_and_extract "https://ftp.gnu.org/gnu/gdb/gdb-$GDB_VERSION.tar.bz2" gdb-"$GDB_VERSION"

# Enter the source directory and patch the source code.
cd gdb-"$GDB_VERSION"
patch -p1 < ../../patches/gdb-"$GDB_VERSION"-PSP.patch

if [ -f ../../patches/gdb-"$GDB_VERSION"-fixes.patch ]
then
	patch -p1 < ../../patches/gdb-"$GDB_VERSION"-fixes.patch
fi

# Create and enter the build directory.
mkdir build-psp
cd build-psp

# Configure the build.
../configure --prefix="$PSPDEV" --target="psp" --disable-werror --with-system-zlib --with-system-readline

# Compile and install.
# We are doing readline first because there seems to be a bug if we don't do it first.
run_make maybe-configure-readline
run_make maybe-all-readline
run_make
run_make install
run_make clean

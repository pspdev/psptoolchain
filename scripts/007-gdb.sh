#!/bin/bash
# gdb.sh by Naomi Peori (naomi@peori.ca)

# Exit on errors
set -e

GDB_VERSION=7.5

# Download the source code if it does not already exist.
download_and_extract https://ftp.gnu.org/gnu/gdb/gdb-$GDB_VERSION.tar.bz2 gdb-$GDB_VERSION

# Enter the source directory and patch the source code.
cd gdb-"$GDB_VERSION"
patch -p1 < ../../patches/gdb-"$GDB_VERSION"-PSP.patch
patch -p1 < ../../patches/gdb-"$GDB_VERSION"-fixes.patch

# Create and enter the build directory.
mkdir build-psp
cd build-psp

# Configure the build.
 CFLAGS="$CFLAGS -I/opt/local/include" \
   CPPFLAGS="$CPPFLAGS -I/opt/local/include" \
   LDFLAGS="$LDFLAGS -L/opt/local/lib" \
  ../configure --prefix="$PSPDEV" --target="psp" --disable-werror --disable-nls \
  --with-system-zlib --with-system-readline

# Compile and install.
make -j $(num_cpus) clean
make -j $(num_cpus)
make -j $(num_cpus) install
make -j $(num_cpus) clean

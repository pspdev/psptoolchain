#!/bin/bash
# binutils.sh by Naomi Peori (naomi@peori.ca)

# Exit on errors
set -e

BINUTILS_VERSION=2.23.2

# Download the source code if it does not already exist.
download_and_extract https://ftp.gnu.org/pub/gnu/binutils/binutils-"$BINUTILS_VERSION".tar.bz2 binutils-"$BINUTILS_VERSION"

# Enter the source directory and patch the source code.
cd binutils-"$BINUTILS_VERSION"
patch -p1 < ../../patches/binutils-"$BINUTILS_VERSION"-PSP.patch


# Create and enter the build directory.
mkdir build-psp
cd build-psp

# Configure the build.
CFLAGS="$CFLAGS -I/opt/local/include" \
  CPPFLAGS="$CPPFLAGS -I/opt/local/include" \
  LDFLAGS="$LDFLAGS -L/opt/local/lib" \
  ../configure --prefix="$PSPDEV" --target="psp" --enable-install-libbfd \
  --enable-plugins --disable-werror --with-system-zlib

# Compile and install. ( -r is required for building under osx )
make -j $(num_cpus) clean
make -r -j $(num_cpus)
make -j $(num_cpus) install-strip
make -j $(num_cpus) clean

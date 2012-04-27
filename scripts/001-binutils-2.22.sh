#!/bin/sh
# binutils-2.22.sh by Dan Peori (danpeori@oopo.net)

 ## Exit on errors
 set -e

 ## Download the source code.
 wget --continue ftp://ftp.gnu.org/pub/gnu/binutils/binutils-2.22.tar.bz2

 ## Unpack the source code.
 rm -Rf binutils-2.22
 tar xfj binutils-2.22.tar.bz2

 ## Enter the source directory and patch the source code.
 cd binutils-2.22
 patch -p1 < ../../patches/binutils-2.22-PSP.patch

 ## Create and enter the build directory.
 mkdir build-psp
 cd build-psp

 ## Configure the build.
 ../configure --prefix="$PSPDEV" --target="psp" --enable-install-libbfd

 ## Compile and install. ( -r is required for building under osx )
 make clean
 make -r -j 2
 make install
 make clean

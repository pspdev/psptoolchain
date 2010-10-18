#!/bin/sh
# gcc-4.3.2-stage2.sh by Dan Peori (danpeori@oopo.net)

 ## Exit on errors
 set -e

 ## Download the source code.
 wget --continue ftp://ftp.gnu.org/pub/gnu/gcc/gcc-4.3.2/gcc-4.3.2.tar.bz2

 ## Unpack the source code.
 rm -Rf gcc-4.3.2
 tar xfvj gcc-4.3.2.tar.bz2

 ## Enter the source directory and patch the source code.
 cd gcc-4.3.2
 patch -p1 < ../../patches/gcc-4.3.2-PSP.patch

 ## Create and enter the build directory.
 mkdir build-psp
 cd build-psp

 ## Configure the build.
 ../configure --prefix="$PSPDEV" --target="psp" --enable-languages="c,c++" --with-newlib --with-gmp --with-mpfr --enable-cxx-flags="-G0"

 ## Compile and install.
 make clean
 CFLAGS_FOR_TARGET="-G0" make -j 2
 make install
 make clean

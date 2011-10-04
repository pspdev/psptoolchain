#!/bin/sh
# gcc-4.5.3-stage2.sh by Dan Peori (danpeori@oopo.net) customized by yreeen (yreeen@gmail.com)

 ## Exit on errors
 set -e

 ## Download the source code.
 wget --continue ftp://ftp.gnu.org/pub/gnu/gcc/gcc-4.5.3/gcc-4.5.3.tar.bz2

 ## Downlow the library source code.
 wget --continue ftp://ftp.gmplib.org/pub/gmp-5.0.1/gmp-5.0.1.tar.bz2
 wget --continue http://www.multiprecision.org/mpc/download/mpc-0.8.2.tar.gz
 wget --continue http://www.mpfr.org/mpfr-2.4.2/mpfr-2.4.2.tar.bz2

 ## Unpack the source code.
 rm -Rf gcc-4.5.3
 tar xfvj gcc-4.5.3.tar.bz2

 ## Enter the source directory and patch the source code.
 cd gcc-4.5.3
 patch -p1 < ../../patches/gcc-4.5.3-PSP.patch

 ## Unpack the library source code.
 tar xfvj ../gmp-5.0.1.tar.bz2 && ln -s gmp-5.0.1 gmp
 tar xfvz ../mpc-0.8.2.tar.gz && ln -s mpc-0.8.2 mpc
 tar xfvj ../mpfr-2.4.2.tar.bz2 && ln -s mpfr-2.4.2 mpfr

 ## Create and enter the build directory.
 mkdir build-psp
 cd build-psp

 ## Configure the build.
 ../configure --prefix="$PSPDEV" --target="psp" --enable-languages="c,c++" --enable-lto --with-newlib --with-gmp --with-mpfr --enable-cxx-flags="-G0"

 ## Compile and install.
 make clean
 CFLAGS_FOR_TARGET="-G0" make -j 2
 make install
 make clean

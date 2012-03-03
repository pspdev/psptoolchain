#!/bin/sh
# gcc-stage2.sh by Dan Peori (danpeori@oopo.net) customized by yreeen (yreeen@gmail.com)
# gdc support from TurkeyMan( https://github.com/TurkeyMan )

 ## set gcc version
 GCC_VERSION=4.6.3

 ## Exit on errors
 set -e

 ## Download the source code.
 wget --continue ftp://ftp.gnu.org/pub/gnu/gcc/gcc-$GCC_VERSION/gcc-$GCC_VERSION.tar.bz2

 ## Download the library source code.
 wget --continue ftp://ftp.gmplib.org/pub/gmp-5.0.2/gmp-5.0.2.tar.bz2
 wget --continue http://www.multiprecision.org/mpc/download/mpc-0.8.2.tar.gz
 wget --continue http://www.mpfr.org/mpfr-3.1.0/mpfr-3.1.0.tar.bz2

 ## Unpack the source code.
 rm -Rf gcc-$GCC_VERSION
 tar xfj gcc-$GCC_VERSION.tar.bz2

 ## Enter the source directory and patch the source code.
 cd gcc-$GCC_VERSION
 patch -p1 < ../../patches/gcc-$GCC_VERSION-PSP.patch

 ## Unpack the library source code.
 tar xfj ../gmp-5.0.2.tar.bz2 && ln -s gmp-5.0.2 gmp
 tar xfz ../mpc-0.8.2.tar.gz && ln -s mpc-0.8.2 mpc
 tar xfj ../mpfr-3.1.0.tar.bz2 && ln -s mpfr-3.1.0 mpfr

 ## Create and enter the build directory.
 mkdir build-psp
 cd build-psp

 ## Configure the build.
 ## If you want to build gdc add "d" to --enable-languages option.
 ../configure --prefix="$PSPDEV" --target="psp" --enable-languages="c,c++" --enable-lto --with-newlib --with-gmp --with-mpfr --enable-cxx-flags="-G0"

 ## Compile and install.
 make clean
 CFLAGS_FOR_TARGET="-G0" make -j 2
 make install
 make clean

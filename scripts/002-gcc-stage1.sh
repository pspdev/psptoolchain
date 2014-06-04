#!/bin/bash
# gcc-stage1.sh by Dan Peori (danpeori@oopo.net) customized by yreeen(yreeen@gmail.com)

 ## set gcc version
 GCC_VERSION=4.6.3
 GMP_VERSION=5.1.0
 MPC_VERSION=1.0.1
 MPFR_VERSION=3.1.1

 ## Exit on errors
 set -e

 ## Download the source code if it does not already exist.
 download_and_extract ftp://ftp.gnu.org/pub/gnu/gcc/gcc-$GCC_VERSION/gcc-$GCC_VERSION.tar.bz2 gcc-$GCC_VERSION

 ## Download the library source code if it does not already exist.
 download_and_extract ftp://ftp.gmplib.org/pub/gmp-$GMP_VERSION/gmp-$GMP_VERSION.tar.bz2 gmp-$GMP_VERSION
 download_and_extract http://www.multiprecision.org/mpc/download/mpc-$MPC_VERSION.tar.gz mpc-$MPC_VERSION
 download_and_extract http://www.mpfr.org/mpfr-$MPFR_VERSION/mpfr-$MPFR_VERSION.tar.bz2 mpfr-$MPFR_VERSION

 ## Enter the source directory and patch the source code.
 cd gcc-$GCC_VERSION
 patch -p1 < ../../patches/gcc-$GCC_VERSION-PSP.patch
 patch -p1 < ../../patches/gcc-$GCC_VERSION-texinfofix.patch
 patch -p2 < ../../patches/gcc-$GCC_VERSION-fix54638.patch

 ## Unpack the library source code.
 ln -fs ../gmp-$GMP_VERSION.tar.bz2 gmp
 ln -fs ../mpc-$MPC_VERSION.tar.gz mpc
 ln -fs ../mpfr-$MPFR_VERSION.tar.bz2 mpfr

 ## Create and enter the build directory.
 mkdir build-psp
 cd build-psp

 ## Configure the build.
 CFLAGS="$CFLAGS -I/opt/local/include" CPPFLAGS="$CPPFLAGS -I/opt/local/include" LDFLAGS="$LDFLAGS -L/opt/local/lib" ../configure --prefix="$PSPDEV" --target="psp" --enable-languages="c" --enable-lto --with-newlib --with-gmp --with-mpfr --without-headers --disable-libssp

 ## Compile and install.
 make clean
 make -j 2
 make install
 make clean

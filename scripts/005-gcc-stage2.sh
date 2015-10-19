#!/bin/bash
# gcc-stage2.sh by Dan Peori (danpeori@oopo.net) customized by yreeen (yreeen@gmail.com)
# gdc support from TurkeyMan( https://github.com/TurkeyMan )

 ## set gcc version
 GCC_VERSION=4.9.3
 GMP_VERSION=5.1.3
 MPC_VERSION=1.0.2
 MPFR_VERSION=3.1.2
 
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
 patch -p1 -i ../../patches/gcc-$GCC_VERSION-PSP.patch
 patch -p0 -i ../../patches/patch-gcc_cp_cfns.h

 ## Unpack the library source code.
 ln -fs ../gmp-$GMP_VERSION gmp
 ln -fs ../mpc-$MPC_VERSION mpc
 ln -fs ../mpfr-$MPFR_VERSION mpfr

 ## Create and enter the build directory.
 mkdir build-psp
 cd build-psp

 ## Configure the build.
 ## If you want to build gdc add "d" to --enable-languages option.
 CFLAGS="$CFLAGS -I/opt/local/include" CPPFLAGS="$CPPFLAGS -I/opt/local/include" LDFLAGS="$LDFLAGS -L/opt/local/lib" ../configure --prefix="$PSPDEV" --target="psp" --enable-languages="c,c++" --enable-lto --with-newlib --with-gmp-include="$(pwd)/gmp" --with-gmp-lib="$(pwd)/gmp/.libs" --with-mpfr-include="$(pwd)/../mpfr/src" --with-mpfr-lib="$(pwd)/mpfr/src/.libs" --enable-cxx-flags="-G0"

 ## Compile and install.
 make -j $(num_cpus) clean
 CFLAGS_FOR_TARGET="-G0" make -j $(num_cpus)
 make -j $(num_cpus) install
 make -j $(num_cpus) clean

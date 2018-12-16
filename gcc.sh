#!/bin/bash
# gcc.sh
# Based on gcc-stage1.sh and gcc-stage2.sh by Naomi Peori (naomi@peori.ca) customized by yreeen(yreeen@gmail.com)

 ## set gcc version
 GCC_VERSION=8.2.0
 GMP_VERSION=6.1.2
 MPC_VERSION=1.1.0
 MPFR_VERSION=4.0.1
 ISL_VERSION=0.20

 ## Exit on errors
 set -e

 ## Download the source code if it does not already exist.
 download_and_extract https://ftp.gnu.org/gnu/gcc/gcc-$GCC_VERSION/gcc-$GCC_VERSION.tar.xz gcc-$GCC_VERSION

 ## Download the library source code if it does not already exist.
 download_and_extract https://ftp.gnu.org/gnu/gmp/gmp-$GMP_VERSION.tar.xz gmp-$GMP_VERSION
 download_and_extract https://ftp.gnu.org/gnu/mpc/mpc-$MPC_VERSION.tar.gz mpc-$MPC_VERSION
 download_and_extract https://ftp.gnu.org/gnu/mpfr/mpfr-$MPFR_VERSION.tar.xz mpfr-$MPFR_VERSION
 download_and_extract http://isl.gforge.inria.fr/isl-$ISL_VERSION.tar.xz isl-$ISL_VERSION

 ## Enter the source directory and patch the source code.
 cd gcc-$GCC_VERSION
 patch -p1 < ../../patches/gcc-$GCC_VERSION-PSP.patch

 ## Unpack the library source code.
 ln -fs ../gmp-$GMP_VERSION gmp
 ln -fs ../mpc-$MPC_VERSION mpc
 ln -fs ../mpfr-$MPFR_VERSION mpfr
 ln -fs ../isl-$ISL_VERSION isl

 ## Create and enter the build directory.
 mkdir build-psp
 cd build-psp

 builddir="$(pwd)"
 srcdir="$builddir/.."

 ## Configure the build.
 ../configure --prefix="$PSPDEV" --target="psp" --enable-languages="c,lto$EXTRA_LANGUAGES" --enable-lto --with-newlib $EXTRA_CONFIGURE_FLAGS

 ## Compile and install.
 make -j $(num_cpus) clean
 make -j $(num_cpus)
 make -j $(num_cpus) install
 make -j $(num_cpus) clean

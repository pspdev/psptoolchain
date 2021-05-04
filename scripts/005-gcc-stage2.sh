#!/bin/bash
# gcc-stage2.sh by Naomi Peori (naomi@peori.ca) customized by yreeen (yreeen@gmail.com)
# gdc support from TurkeyMan( https://github.com/TurkeyMan )

 ## set gcc version
 GCC_VERSION=9.3.0
 GMP_VERSION=6.1.2
 MPC_VERSION=1.1.0
 MPFR_VERSION=4.0.2
 ISL_VERSION=0.21

 ## Exit on errors
 set -e

 ## Download the source code if it does not already exist.
 download_and_extract https://ftp.gnu.org/gnu/gcc/gcc-$GCC_VERSION/gcc-$GCC_VERSION.tar.gz gcc-$GCC_VERSION

 ## Download the library source code if it does not already exist.
 download_and_extract https://ftp.gnu.org/gnu/gmp/gmp-$GMP_VERSION.tar.bz2 gmp-$GMP_VERSION
 download_and_extract https://ftp.gnu.org/gnu/mpc/mpc-$MPC_VERSION.tar.gz mpc-$MPC_VERSION
 download_and_extract https://ftp.gnu.org/gnu/mpfr/mpfr-$MPFR_VERSION.tar.bz2 mpfr-$MPFR_VERSION
 download_and_extract http://isl.gforge.inria.fr/isl-$ISL_VERSION.tar.gz isl-$ISL_VERSION

 ## Enter the source directory and patch the source code.
 cd gcc-$GCC_VERSION
 patch -p1 -i ../../patches/gcc-$GCC_VERSION-PSP.patch

 ## Unpack the library source code.
 ln -fs ../gmp-$GMP_VERSION gmp
 ln -fs ../mpc-$MPC_VERSION mpc
 ln -fs ../mpfr-$MPFR_VERSION mpfr
 ln -fs ../isl-$ISL_VERSION isl

 ## Create and enter the build directory.
 mkdir build-psp
 cd build-psp

 ## Under macOS we need the gnu variant of sed
 if [ "$(uname)" == "Darwin" ]; then
   export PATH="/usr/local/opt/gnu-sed/libexec/gnubin:/opt/local/libexec/gnubin:$PATH"
 fi

 ## Configure the build.
 ## If you want to build gdc add "d" to --enable-languages option.
 CFLAGS="$CFLAGS -I/opt/local/include" \
   CPPFLAGS="$CPPFLAGS -I/opt/local/include" \
   LDFLAGS="$LDFLAGS -L/opt/local/lib" \
   ../configure --prefix="$PSPDEV" --target="psp" --enable-languages="c,c++" \
   --enable-lto --with-newlib --enable-cxx-flags="-G0"

 ## Compile and install.
 make -j $(num_cpus) clean
 CFLAGS_FOR_TARGET="-G0" make -j $(num_cpus)
 make -j $(num_cpus) install-strip
 make -j $(num_cpus) clean

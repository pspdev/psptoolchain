#!/bin/sh
# gcc-4.5.3-stage2.sh by Dan Peori (danpeori@oopo.net) customized by yreeen (yreeen@gmail.com)
# gdc support from TurkeyMan( https://github.com/TurkeyMan )

 ## Exit on errors
 set -e

 ## Download the source code.
 wget --continue ftp://ftp.gnu.org/pub/gnu/gcc/gcc-4.6.2/gcc-4.6.2.tar.bz2

 ## Download the library source code.
 wget --continue ftp://ftp.gmplib.org/pub/gmp-5.0.2/gmp-5.0.2.tar.bz2
 wget --continue http://www.multiprecision.org/mpc/download/mpc-0.8.2.tar.gz
 wget --continue http://www.mpfr.org/mpfr-3.1.0/mpfr-3.1.0.tar.bz2

 ## Unpack the source code.
 rm -Rf gcc-4.6.2
 tar xfj gcc-4.6.2.tar.bz2

 ## Extra step for gdc: unpack and move into gcc
 wget --continue https://bitbucket.org/take_cheeze/gdc/get/default.zip
 rm -Rf take_cheeze-gdc-default
 unzip default.zip
 cp -a take_cheeze-gdc-default/d gcc-4.5.3/gcc/d

 ## Enter the source directory and patch the source code.
 cd gcc-4.6.2
 patch -p1 < ../../patches/gcc-4.6.2-PSP.patch

 ## Extra step for gdc: apply D2 patches.
 ./gcc/d/setup-gcc.sh -v2

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

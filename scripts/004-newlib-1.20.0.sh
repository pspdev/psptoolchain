#!/bin/bash
# newlib-1.20.0.sh by Dan Peori (danpeori@oopo.net)

 ## Exit on errors
 set -e

 ## Download the source code if it does not already exist.
 download_and_extract ftp://sourceware.org/pub/newlib/newlib-1.20.0.tar.gz newlib-1.20.0

 ## Enter the source directory and patch the source code.
 cd newlib-1.20.0
 patch -p1 < ../../patches/newlib-1.20.0-PSP.patch

 ## Create and enter the build directory.
 mkdir build-psp
 cd build-psp

 ## Configure the build.
 ../configure --prefix="$PSPDEV" --target="psp" \
     --enable-newlib-iconv \
     --enable-newlib-multithread \
     --enable-newlib-mb \

 ## Compile and install.
 make -j $(num_cpus) clean
 make -j $(num_cpus)
 make -j $(num_cpus) install
 make -j $(num_cpus) clean

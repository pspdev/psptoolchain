#!/bin/sh
# newlib-1.20.0.sh by Dan Peori (danpeori@oopo.net)

 ## Exit on errors
 set -e

 ## Download the source code.
 wget --continue ftp://sources.redhat.com/pub/newlib/newlib-1.20.0.tar.gz

 ## Unpack the source code.
 rm -Rf newlib-1.20.0
 tar xfz newlib-1.20.0.tar.gz

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
 make clean
 make -j 2
 make install
 make clean

#!/bin/sh
# gdb-7.3.1.sh by Dan Peori (danpeori@oopo.net)

 ## Exit on errors
 set -e

 ## Download the source code.
 wget --continue ftp://ftp.gnu.org/pub/gnu/gdb/gdb-7.3.1.tar.bz2

 ## Unpack the source code.
 rm -Rf gdb-7.3.1
 tar xfj gdb-7.3.1.tar.bz2

 ## Enter the source directory and patch the source code.
 cd gdb-7.3.1
 patch -p1 < ../../patches/gdb-7.3.1-fix-stpcpy.patch
 patch -p1 < ../../patches/gdb-7.3.1-PSP.patch

 ## Create and enter the build directory.
 mkdir build-psp
 cd build-psp

 ## Configure the build.
 ../configure --prefix="$PSPDEV" --target="psp" --disable-werror --disable-nls

 ## Compile and install.
 make clean
 make -j 2
 make install
 make clean

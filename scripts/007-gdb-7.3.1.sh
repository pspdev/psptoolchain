#!/bin/bash
# gdb-7.3.1.sh by Dan Peori (danpeori@oopo.net)

 ## Exit on errors
 set -e

 ## Download the source code if it does not already exist.
 download_and_extract ftp://ftp.gnu.org/pub/gnu/gdb/gdb-7.3.1.tar.bz2 gdb-7.3.1

 ## Enter the source directory and patch the source code.
 cd gdb-7.3.1
 patch -p1 < ../../patches/gdb-7.3.1-fix-stpcpy.patch
 patch -p1 < ../../patches/gdb-7.3.1-PSP.patch
 patch -p1 < ../../patches/gdb-7.3.1-texinfofix.patch
 patch -p1 < ../../patches/gdb-7.3.1-fix-sim-arange.patch

 ## Create and enter the build directory.
 mkdir build-psp
 cd build-psp

 ## Configure the build.
 CFLAGS="$CFLAGS -I/opt/local/include" CPPFLAGS="$CPPFLAGS -I/opt/local/include" LDFLAGS="$LDFLAGS -L/opt/local/lib" ../configure --prefix="$PSPDEV" --target="psp" --disable-werror --disable-nls

 ## Compile and install.
 make clean
 make -j 2
 make install
 make clean

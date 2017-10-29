#!/bin/bash
# binutils-2.22.sh by Dan Peori (danpeori@oopo.net)

 ## Exit on errors
 set -e

 ## Download the source code if it does not already exist.
 download_and_extract https://ftp.gnu.org/pub/gnu/binutils/binutils-2.22.tar.bz2 binutils-2.22

 ## Enter the source directory and patch the source code.
 cd binutils-2.22
 patch -p1 < ../../patches/binutils-2.22-PSP.patch
 patch -p1 < ../../patches/binutils-2.22-texinfofix.patch

 ## Create and enter the build directory.
 mkdir build-psp
 cd build-psp

 ## Configure the build.
 CFLAGS="$CFLAGS -I/opt/local/include -Wno-error" CPPFLAGS="$CPPFLAGS -I/opt/local/include -Wno-error" LDFLAGS="$LDFLAGS -L/opt/local/lib" ../configure --prefix="$PSPDEV" --target="psp" --enable-install-libbfd

 ## Compile and install. ( -r is required for building under osx )
 make -j $(num_cpus) clean
 make -r -j $(num_cpus)
 make -j $(num_cpus) install
 make -j $(num_cpus) clean

#!/bin/bash
# insight-6.8.sh by Dan Peori (danpeori@oopo.net)
exit;

 ## Exit on errors
 set -e

 ## Download the source code if it does not already exist.
 download_and_extract https://sourceware.org/pub/insight/releases/insight-6.8a.tar.bz2 insight-6.8

 ## Enter the source directory and patch the source code.
 cd insight-6.8
 patch -p1 < ../../patches/insight-6.8-PSP.patch

 ## Create and enter the build directory.
 mkdir build-psp
 cd build-psp

 ## Configure the build.
 CFLAGS="$CFLAGS -I/opt/local/include" CPPFLAGS="$CPPFLAGS -I/opt/local/include" LDFLAGS="$LDFLAGS -L/opt/local/lib" ../configure --prefix="$PSPDEV" --target="psp" --disable-nls --disable-werror

 ## Compile and install.
 make -j $(num_cpus) clean
 make -j $(num_cpus)
 make -j $(num_cpus) install
 make -j $(num_cpus) clean

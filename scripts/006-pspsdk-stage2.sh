#!/bin/sh
# pspsdk-stage2.sh by Dan Peori (danpeori@oopo.net)

 ## Exit on errors
 set -e

 ## Download the source code.
 wget --continue --no-check-certificate https://github.com/pspdev/pspsdk/tarball/master -O pspsdk.tar.gz

 ## Unpack the source code.
 rm -Rf pspsdk && mkdir pspsdk && tar --strip-components=1 --directory=pspsdk -xzf pspsdk.tar.gz

 ## Enter the source directory.
 cd pspsdk

 ## Bootstrap the source.
 ./bootstrap

 ## Configure the build.
 CFLAGS="$CFLAGS -I/opt/local/include" CPPFLAGS="$CPPFLAGS -I/opt/local/include" LDFLAGS="$LDFLAGS -L/opt/local/lib" ./configure --with-pspdev="$PSPDEV"

 ## Build and install.
 make clean
 make
 make install
 make clean

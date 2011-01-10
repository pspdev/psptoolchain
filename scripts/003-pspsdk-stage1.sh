#!/bin/sh
# pspsdk-stage1.sh by Dan Peori (danpeori@oopo.net)

 ## Exit on errors
 set -e

 ## Download the source code.
 wget --continue --no-check-certificate https://github.com/ooPo/pspsdk/tarball/master -O pspsdk.tar.gz

 ## Unpack the source code.
 rm -Rf pspsdk && mkdir pspsdk && tar --strip-components=1 --directory=pspsdk -xvzf pspsdk.tar.gz

 ## Enter the source directory.
 cd pspsdk

 ## Bootstrap the source.
 ./bootstrap

 ## Configure the build.
 ./configure --with-pspdev="$PSPDEV"

 ## Build and install.
 make clean
 make install-data
 make clean

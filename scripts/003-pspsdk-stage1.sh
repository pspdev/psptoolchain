#!/bin/sh
# pspsdk-stage1.sh by Dan Peori (danpeori@oopo.net)

 ## Exit on errors
 set -e

 ## Download the source code.
 if test ! -d "pspsdk"; then
  svn checkout svn://svn.ps2dev.org/psp/trunk/pspsdk
 else
  svn update pspsdk
 fi

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

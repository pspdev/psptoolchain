#!/bin/sh
# psplinkusb.sh by Dan Peori (danpeori@oopo.net)

 ## Exit on errors
 set -e

 ## Download the source code.
 wget --continue --no-check-certificate https://github.com/pspdev/psplinkusb/tarball/master -O psplinkusb.tar.gz

 ## Unpack the source code.
 rm -Rf psplinkusb && mkdir psplinkusb && tar --strip-components=1 --directory=psplinkusb -xvzf psplinkusb.tar.gz

 ## Enter the source directory.
 cd psplinkusb

 ## Build and install.
 make -f Makefile.clients clean
 make -f Makefile.clients
 make -f Makefile.clients install
 make -f Makefile.clients clean


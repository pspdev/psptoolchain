#!/bin/sh
# psplinkusb.sh by Dan Peori (danpeori@oopo.net)

 ## Exit on errors
 set -e
 
 ## Download the source code.
 wget --continue --no-check-certificate https://github.com/pspdev/psplinkusb/tarball/master -O psplinkusb.tar.gz

 ## Unpack the source code.
 rm -Rf psplinkusb && mkdir psplinkusb && tar --strip-components=1 --directory=psplinkusb -xzf psplinkusb.tar.gz

 ## Enter the source directory and patch the source code.
 cd psplinkusb

unamestr=`uname`
 if [[ "$unamestr" == 'Darwin' ]]; then
   patch -p1 < ../../patches/psplinkusb-Darwin.patch
 fi

 ## MacPorts fix
 export C_INCLUDE_PATH="/opt/local/include"
 export CPLUS_INCLUDE_PATH="/opt/local/include"
 export LIBRARY_PATH="/opt/local/lib"

 ## Build and install.
 make -f Makefile.clients clean
 make -f Makefile.clients
 make -f Makefile.clients install
 make -f Makefile.clients clean


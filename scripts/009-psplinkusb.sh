#!/bin/sh
# psplinkusb.sh by Dan Peori (danpeori@oopo.net)

 ## Exit on errors
 set -e
 
 ## Download legacy version of libusb.
 wget --continue http://downloads.sourceforge.net/project/libusb/libusb-0.1%20%28LEGACY%29/0.1.12/libusb-0.1.12.tar.gz?r=http%3A%2F%2Fsourceforge.net%2Fprojects%2Flibusb%2Ffiles%2Flibusb-0.1%2520%2528LEGACY%2529%2F0.1.12%2F&ts=1340988823&use_mirror=voxel -O libusb-legacy.tar.gz
 
 ## Unpack the source code
 rm -Rf libusb-legacy && mkdir libusb-legacy && tar --strip-components=1 --directory=psplinkusb -xzf libusb-legacy.tar.gz
 
 ## Enter the source directory.
 cd libusb-legacy
 
 ## Install legacy libusb.
 ./configure && make && make install
 
 ## Jump back out.
 cd ../

 ## Download the source code.
 wget --continue --no-check-certificate https://github.com/pspdev/psplinkusb/tarball/master -O psplinkusb.tar.gz

 ## Unpack the source code.
 rm -Rf psplinkusb && mkdir psplinkusb && tar --strip-components=1 --directory=psplinkusb -xzf psplinkusb.tar.gz

 ## Enter the source directory.
 cd psplinkusb
 
 ## MacPorts fix
 export C_INCLUDE_PATH="/opt/local/include"
 export CPLUS_INCLUDE_PATH="/opt/local/include"
 export LIBRARY_PATH="/opt/local/lib"

 ## Build and install.
 make -f Makefile.clients clean
 make -f Makefile.clients
 make -f Makefile.clients install
 make -f Makefile.clients clean


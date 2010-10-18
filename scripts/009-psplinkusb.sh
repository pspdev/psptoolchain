#!/bin/sh
# psplinkusb.sh by Dan Peori (danpeori@oopo.net)

 ## Exit on errors
 set -e

 ## Download the source code.
 if test ! -d "psplinkusb"; then
  svn checkout svn://svn.ps2dev.org/psp/trunk/psplinkusb
 else
  svn update psplinkusb
 fi

 ## Enter the source directory.
 cd psplinkusb

 ## Build and install.
 make -f Makefile.clients clean
 make -f Makefile.clients
 make -f Makefile.clients install
 make -f Makefile.clients clean


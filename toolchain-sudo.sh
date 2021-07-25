#!/bin/bash
# toolchain-sudo.sh by Naomi Peori (naomi@peori.ca)
 
 INSTALLDIR=/opt/toolchains/psp/pspdev
 
 ## Enter the psptoolchain directory.
 cd "`dirname $0`" || { echo "ERROR: Could not enter the psptoolchain directory."; exit 1; }

 ## Set up the environment.
 export PSPDEV=$INSTALLDIR
 export PATH=$PATH:$PSPDEV/bin

 ## Run the toolchain script.
 ./toolchain.sh $@ || { echo "ERROR: Could not run the toolchain script."; exit 1; }

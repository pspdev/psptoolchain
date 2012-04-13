#!/bin/sh
# ebootsigner.sh by Sam Hegarty (samr.hegarty@gmail.com)
# Modification of script by Dan Peori (danpeori@oopo.net)

 ## Exit on errors
 set -e

 ## Download the source code.
 wget --continue --no-check-certificate https://github.com/int-0/ebootsigner/tarball/master -O ebootsigner.tar.gz

 ## Unpack the source code.
 rm -Rf ebootsigner && mkdir ebootsigner && tar --strip-components=1 --directory=ebootsigner -xzf ebootsigner.tar.gz

 ## Enter the source directory.
 cd ebootsigner
 
 ## Build and install
 make && make install


#!/bin/bash
# psp-pacman.sh by Wouter Wijsman (wwijsman@live.nl)

 ## clear CC and CXX
 unset CC
 unset CXX

 ## Exit on errors
 set -e

 PACMAN_VERSION="5.2.1"

 ## Download the source code
 download_and_extract https://sources.archlinux.org/other/pacman/pacman-${PACMAN_VERSION}.tar.gz pacman-${PACMAN_VERSION}
 
 ## Enter the source directory
 cd pacman-${PACMAN_VERSION}

 ## Apply patch
 patch -p1 < ../../patches/pacman-${PACMAN_VERSION}.patch

 ## Build
 ./configure --prefix=${PSPDEV} --with-buildscript=PSPBUILD --with-root-dir=${PSPDEV}/psp --program-prefix="psp-" --disable-doc
 make
 make install
 
 ## Overwrite config files
 cp -f ../../patches/makepkg.conf ${PSPDEV}/etc/makepkg.conf
 cp -f ../../patches/pacman.conf ${PSPDEV}/etc/pacman.conf

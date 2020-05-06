#!/bin/bash
# psp-pacman.sh by Wouter Wijsman (wwijsman@live.nl)

 ## clear CC and CXX
 unset CC
 unset CXX

 ## Exit on errors
 set -e

 PACMAN_VERSION="5.2.1"

 ## Download the source code
 git clone git://git.archlinux.org/pacman.git
 
 ## Enter the source directory
 cd pacman

 ## Apply patch
 patch -p1 < ../../patches/pacman-${PACMAN_VERSION}.patch

 ## Create and load venv
python3 -m venv venv
. venv/bin/activate

 ## Install python based build dependencies
 pip install meson ninja

 ## Build
 meson build
 meson configure build -Dprefix=${PSPDEV}/share/pacman -Dbuildscript=PSPBUILD -Droot-dir=${PSPDEV}/psp -Ddoc=disabled
 cd build
 ninja install
 cd ..
 
 ## Overwrite config files
 cp -f ../../patches/makepkg.conf ${PSPDEV}/etc/makepkg.conf
 cp -f ../../patches/pacman.conf ${PSPDEV}/etc/pacman.conf

 ## Make symlinks
 ln -sf ${PSPDEV}/share/pacman/bin/pacman ${PSPDEV}/bin/psp-pacman
 ln -sf ${PSPDEV}/share/pacman/bin/makepkg ${PSPDEV}/bin/psp-makepkg

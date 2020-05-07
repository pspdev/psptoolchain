#!/bin/bash
# psp-pacman.sh by Wouter Wijsman (wwijsman@live.nl)

 ## clear CC and CXX
 unset CC
 unset CXX

 ## Exit on errors
 set -e

 PACMAN_VERSION="5.2.1"
 INSTALL_DIR="${PSPDEV}/share/pacman"

 ## Download the source code
download_and_extract https://sources.archlinux.org/other/pacman/pacman-${PACMAN_VERSION}.tar.gz pacman-${PACMAN_VERSION}
 
 ## Enter the source directory
 cd pacman-${PACMAN_VERSION}

 ## Apply patch
 patch -p1 < ../../patches/pacman-${PACMAN_VERSION}.patch

 ## Create and load venv
python3 -m venv venv
. venv/bin/activate

 ## Install python based build dependencies
 pip install meson ninja

 ## Build
 meson build
 meson configure build -Dprefix=${INSTALL_DIR} -Dbuildscript=PSPBUILD -Droot-dir=${PSPDEV}/psp -Ddoc=disabled -Dbash-completion=false
 cd build
 ninja install
 cd ..
 
 ## Overwrite config files
 cp -f ../../patches/makepkg.conf ${INSTALL_DIR}/etc/makepkg.conf
 cp -f ../../patches/pacman.conf ${INSTALL_DIR}/etc/pacman.conf

 ## Make symlinks
 ln -sf ${INSTALL_DIR}/bin/pacman ${PSPDEV}/bin/psp-pacman
 ln -sf ${INSTALL_DIR}/bin/makepkg ${PSPDEV}/bin/psp-makepkg

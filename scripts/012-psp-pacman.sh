#!/bin/bash
# psp-pacman.sh by Wouter Wijsman (wwijsman@live.nl)

 ## clear CC and CXX
 unset CC
 unset CXX

 ## Exit on errors
 set -e

 ## Download the source code.
 clone_git_repo github.com sharkwouter psp-pacman

 ## Enter the source directory.
 cd psp-pacman

 ## Configure the build.
 autoreconf --install
 ./configure
 make
 make install

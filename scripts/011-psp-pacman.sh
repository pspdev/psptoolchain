#!/bin/bash
# psp-pacman.sh by Wouter Wijsman (wwijsman@live.nl)

 ## clear CC and CXX
 unset CC
 unset CXX

 ## Exit on errors
 set -e

 ## Download the source code.
 clone_git_repo github.com pspdev psp-pacman

 ## Enter the source directory.
 cd psp-pacman

 ## Build and install
 ./pacman.sh

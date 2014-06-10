#!/bin/bash
# ebootsigner.sh by Sam Hegarty (samr.hegarty@gmail.com)
# Modification of script by Dan Peori (danpeori@oopo.net)

 ## Exit on errors
 set -e

 ## Download the source code if it does not already exist.
 clone_git_repo github.com int-0 ebootsigner

 ## Enter the source directory.
 cd ebootsigner
 
 ## Build and install
 make && make install


#!/bin/bash
# ebootsigner.sh by Sam Hegarty (samr.hegarty@gmail.com)
# Modification of script by Naomi Peori (naomi@peori.ca)

 ## Exit on errors
 set -e

 ## Download the source code if it does not already exist.
 clone_git_repo github.com int-0 ebootsigner

 ## Enter the source directory.
 cd ebootsigner
 
 ## Build and install
 make -j $(num_cpus)
 make -j $(num_cpus) install

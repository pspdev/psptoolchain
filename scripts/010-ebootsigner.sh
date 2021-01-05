#!/bin/bash
# ebootsigner.sh by Sam Hegarty (samr.hegarty@gmail.com)
# Modification of script by Naomi Peori (naomi@peori.ca)

 ## Exit on errors
 set -e

 ## Download the source code if it does not already exist.
 git clone https://github.com/pspdev/ebootsigner --depth=1

 ## Enter the source directory.
 cd ebootsigner
 
 ## Build and install
 make -j $(num_cpus)
 make -j $(num_cpus) install

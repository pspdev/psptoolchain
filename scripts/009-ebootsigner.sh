#!/bin/bash
# ebootsigner.sh by Sam Hegarty (samr.hegarty@gmail.com)
# Modification of script by Naomi Peori (naomi@peori.ca)

. ../common.sh

# Exit on errors
set -e

# Download the source code if it does not already exist.
clone_git_repo 'https://github.com/int-0/ebootsigner/' ebootsigner

# Enter the source directory.
cd ebootsigner

# Build and install
run_make
run_make install

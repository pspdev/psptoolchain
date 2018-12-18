#!/bin/bash
# pspsdk-stage2.sh by Naomi Peori (naomi@peori.ca)

. ../common.sh

# Exit on errors
set -e

# Download the source code if it does not already exist.
clone_git_repo 'https://github.com/pspdev/pspsdk/' pspsdk-stage2

# Enter the source directory.
cd pspsdk-stage2

# Bootstrap the source.
./bootstrap

# Configure the build.
./configure --with-pspdev="$PSPDEV"

## Build and install.
run_make
run_make install
run_make clean

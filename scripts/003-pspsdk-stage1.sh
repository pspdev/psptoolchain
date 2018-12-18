#!/bin/bash
# pspsdk-stage1.sh by Naomi Peori (naomi@peori.ca)

. ../common.sh

# Exit on errors
set -e

# Download the source code if it does not already exist.
clone_git_repo 'https://github.com/pspdev/pspsdk/' pspsdk-stage1

# Enter the source directory.
cd pspsdk-stage1

# Bootstrap the source.
./bootstrap

# Configure the build.
./configure --with-pspdev="$PSPDEV"

# Build and install.
run_make install-data
run_make clean

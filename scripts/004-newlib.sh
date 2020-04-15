#!/bin/bash
# newlib-1.20.0.sh by Naomi Peori (naomi@peori.ca)

. ../common.sh

# Exit on errors
set -e

NEWLIB_VERSION=1.20.0
NEWLIB_VERSION_BRANCH=${NEWLIB_VERSION//./_}

# Download the source code if it does not already exist.
clone_git_repo 'https://github.com/pspdev/newlib' newlib-"$NEWLIB_VERSION" newlib-"$NEWLIB_VERSION_BRANCH"-PSP

# Enter the source directory and patch the source code.
cd newlib-"$NEWLIB_VERSION"

# Create and enter the build directory.
mkdir build-psp
cd build-psp

# Configure the build.
../configure --prefix="$PSPDEV" --target="psp" \
	--enable-newlib-iconv \
	--enable-newlib-multithread \
	--enable-newlib-mb

## Compile and install.
run_make
run_make install
run_make clean

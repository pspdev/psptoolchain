#!/bin/bash
# newlib.sh by Naomi Peori (naomi@peori.ca)

## Exit on errors
set -e

## Download the source code if it does not already exist.
clone_git_repo github.com pspdev newlib newlib-3.3.0-psp

## Enter the source directory
cd newlib

## Create and enter the build directory.
mkdir build-psp
cd build-psp

## Configure the build.
../configure --prefix="$PSPDEV" --target="psp" \
  --enable-newlib-iconv --enable-newlib-multithread --enable-newlib-mb

## Compile and install.
make -j $(num_cpus) clean
make -j $(num_cpus)
make -j $(num_cpus) install
make -j $(num_cpus) clean

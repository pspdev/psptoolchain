#!/bin/bash
# psp-pkg-config.sh by carstene1ns (dev f4ke de)

# Exit on errors
set -e

# Download the source code.
git clone https://github.com/pspdev/psp-pkgconf --depth=1

# Enter the source directory.
cd psp-pkgconf

# Build and install.
make -j $(num_cpus)
make install

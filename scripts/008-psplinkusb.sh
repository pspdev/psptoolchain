#!/bin/bash
# psplinkusb.sh by Naomi Peori (naomi@peori.ca)

. ../common.sh

# Exit on errors
set -e

# Download the source code if it does not already exist
clone_git_repo 'https://github.com/pspdev/psplinkusb/' psplinkusb

# Enter the source directory
cd psplinkusb

# Build and install.
run_make -f Makefile.clients
run_make -f Makefile.clients install
run_make -f Makefile.clients clean

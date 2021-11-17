#!/bin/bash

# Install build dependencies
sudo dnf install $@ \
  @development-tools gcc gcc-c++ make cmake git wget autoconf automake \
  texinfo bison flex gmp-devel mpfr-devel libmpc-devel ncurses-devel diffutils \
  python3 python3-pip libarchive-devel openssl-devel libtool
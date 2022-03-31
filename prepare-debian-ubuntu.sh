#!/bin/bash

# Install build dependencies
sudo apt-get install $@ \
  bash autoconf automake make patch cmake g++ gcc git \
  texinfo bison flex gettext pkg-config libncurses5-dev \
  libgmp3-dev libmpfr-dev libmpc-dev libarchive-dev openssl libtool  \
  python3 python3-venv

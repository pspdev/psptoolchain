#!/bin/bash
# gdb.sh by Naomi Peori (naomi@peori.ca)

# Exit on errors
set -e

GDB_VERSION=7.5.1

# Download the source code if it does not already exist.
download_and_extract https://ftp.gnu.org/gnu/gdb/gdb-$GDB_VERSION.tar.bz2 gdb-$GDB_VERSION

# Enter the source directory and patch the source code.
cd gdb-"$GDB_VERSION"
patch -p1 < ../../patches/gdb-"$GDB_VERSION"-PSP.patch
patch -p1 < ../../patches/gdb-"$GDB_VERSION"-fixes.patch

# Create and enter the build directory.
mkdir build-psp
cd build-psp

if [ "$(uname)" == "Darwin" ]; then
  # macports
  if [ -d "/opt/local/include" -a -d "/opt/local/lib" ]; then
    export CFLAGS="$CFLAGS -I/opt/local/include"
    export CPPFLAGS="$CPPFLAGS -I/opt/local/include"
    export LDFLAGS="$LDFLAGS -L/opt/local/lib"
  fi
  # homebrew
  if command -v brew 1>/dev/null 2>&1; then
    export CFLAGS="$CFLAGS -I`brew --prefix`/opt/readline/include"
    export CPPFLAGS="$CPPFLAGS -I`brew --prefix`/opt/readline/include"
    export LDFLAGS="$LDFLAGS -L`brew --prefix`/opt/readline/lib"
  fi
fi

# Configure the build.
../configure --prefix="$PSPDEV" --target="psp" --disable-werror --disable-nls \
  --with-system-zlib --with-system-readline

# Compile and install.
make -j $(num_cpus) clean
make -j $(num_cpus)
make -j $(num_cpus) install
make -j $(num_cpus) clean

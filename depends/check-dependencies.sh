#!/bin/bash

header_paths=(
    "/usr/include" \
    "/usr/local/include" \
    "/opt/include" \
    "/opt/local/include" \
    "/usr/include/$(uname -m)-linux-gnu" \
    "/usr/local/include/$(uname -m)-linux-gnu" \
    "/usr/include/i386-linux-gnu" \
    "/usr/local/include/i386-linux-gnu"
    # -- Add more locations here --
)

aclocal_paths=(
    "/usr/share/aclocal"
    "/usr/local/share/aclocal"
)

missing_depends=()

function check_header
{
    for place in ${header_paths[@]}; do
        for name in ${@:2}; do
            [ -f "$place/$name" ] && return 0
        done
    done
    
    missing_depends+=($1); return 1
}

function check_program
{
    binary=${2:-$1}
    for place in ${PATH//:/ }; do
        [ -x "$place/$binary" ] || [ -x "$place/$binary.exe" ] && return 0
    done
    
    missing_depends+=($1); return 1
}

function check_aclocal
{
    for place in ${aclocal_paths[@]}; do
        [ -f "$place/$2" ] && return 0
    done
    
    missing_depends+=($1); return 1
}



check_header    gmp             gmp.h
check_header    mpc             mpc.h
check_header    mpfr            mpfr.h
check_header    libelf          elf.h libelf.h libelf/libelf.h gelf.h libelf/gelf.h
check_header    libusb          usb.h
check_header    ncurses         ncurses.h ncurses/ncurses.h
check_header    readline        readline.h readline/readline.h
check_header    zlib            zlib.h



check_program   git
check_program   svn
check_program   wget
check_program   patch
check_program   tar
check_program   unzip

check_program   autoconf
check_program   automake
check_program   automake-1.9    # This particular version is needed too
check_program   libtool
check_program   cmake
check_program   make
check_program   gcc
check_program   g++

check_program   sdl-config
check_program   freetype-config

check_program   bison
check_program   flex
check_program   tclsh

check_program   makeinfo
check_program   doxygen



if [ ${#missing_depends[@]} -ne 0 ]; then
    echo "Couldn't find dependencies:"
    for dep in $missing_depends; do
        echo "  - $dep"
    done
	exit 1
fi

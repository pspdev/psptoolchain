#!/bin/bash

header_paths=(
    "/usr/include" \
    "/usr/local/include" \
    "/usr/local/opt/" \
    "/opt/include" \
    "/opt/local/include" \
    "/usr/include/$(uname -m)-linux-gnu" \
    "/usr/local/include/$(uname -m)-linux-gnu" \
    "/usr/include/i386-linux-gnu" \
    "/usr/local/include/i386-linux-gnu" \
    "/mingw32/include/"
    # -- Add more locations here --
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

function check_header_nosys
{
    for place in ${header_paths[@]}; do
        if [ "${place:0:12}" != "/usr/include" ]; then
            for name in ${@:2}; do
                [ -f "$place/$name" ] && return 0
            done
        fi
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

OSVER=$(uname)

# macOS catalina does not ship headers in default directory anymore
if [ "$(uname)" == "Darwin" ]; then
  header_paths+=("`xcrun --show-sdk-path`/usr/include")
fi

check_program   git
check_program   patch
check_program   autoconf
check_program   automake

# Disabled pacman for windows
if [ "${OSVER:0:5}" != MINGW ]; then
check_program   python3
check_program   pip3
check_program   gpgme-config
check_header    openssl             openssl/crypto.h openssl/include/openssl/crypto.h
check_header    libarchive          archive.h libarchive/include/archive.h
fi

check_program   make
check_program   cmake
check_program   gcc
check_program   g++

check_program   bison
check_program   flex
check_program   libtoolize

if [ ${#missing_depends[@]} -ne 0 ]; then
    echo "Couldn't find dependencies:"
    for dep in "${missing_depends[@]}"; do
        echo "  - $dep"
    done
	exit 1
fi

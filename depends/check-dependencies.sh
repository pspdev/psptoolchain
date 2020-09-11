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

missing_depends=()

function check_header_path
{
	for header_path in ${header_paths[@]}; do
    		if [ "$1" == "${header_path}" ] ; then
			return 1
		fi
	done
	header_paths+=( "$1" )
	return 0
}

function check_header 
{
    package_name=`pkg-config --list-package-names | grep $1`
    cflags=`pkg-config ${package_name} --cflags-only-I`
    includedir=`pkg-config --variable=includedir ${package_name}`

    check_header_path ${includedir}

    for place in ${cflags[@]}; do
    	check_header_path "${place#-I}"
    done

    for place in ${header_paths[@]}; do
        for name in ${@:2}; do
            [ -f "$place/$name" ] && return 0
        done
    done

    missing_depends+=($1); return 1
}

function check_header_nosys
{
    package_name=`pkg-config --list-package-names | grep $1`
    cflags=`pkg-config ${package_name} --cflags-only-I`
    includedir=`pkg-config --variable=includedir ${package_name}`

    check_header_path ${includedir}

    for place in ${cflags[@]}; do
    	check_header_path "${place#-I}"
    done

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

# macOS catalina does not ship headers in default directory anymore
if [ "$(uname)" == "Darwin" ]; then
  header_paths+=("`xcrun --show-sdk-path`/usr/include")
fi

check_header    libelf          elf.h libelf.h libelf/libelf.h gelf.h libelf/gelf.h
check_header    libusb          libusb.h
check_header    ncurses         ncurses.h ncurses/ncurses.h
check_header    zlib            zlib.h
check_header    libcurl         curl/curl.h
check_header    gpgme           gpgme.h

check_program   git
check_program   svn
check_program   wget
check_program   patch
check_program   tar
check_program   unzip
check_program   bzip2
check_program   xz

check_program   autoconf
check_program   automake
check_program   cmake
check_program   make
check_program   gcc
check_program   g++
check_program   m4

check_program   bison
check_program   flex
check_program   tclsh
check_program   diff
check_program   which

check_program   makeinfo
check_program   doxygen

check_program   sdl-config

check_program   python3

# Sometimes things will be a little different on Mac OS X...
if [ "$(uname)" == "Darwin" ]; then
    # readline should be checked carefully on OS X to save us from being
    # fooled by BSD libedit.
    # libarchive and openssl are keg-only
    if brew --version 1>/dev/null 2>&1; then
        header_paths+=("`brew --prefix`/opt/readline/include")
        header_paths+=("`brew --prefix`/opt/libarchive/include")
        header_paths+=("`brew --prefix`/opt/openssl/include")
    fi
    check_header_nosys libarchive   archive.h
    check_header_nosys libssl       openssl/ssl.h

    check_header_nosys readline     readline.h readline/readline.h

    # GNU libtool will be prepended with letter 'g' to prevent conflicts with
    # the one comes along with OS X.
    check_program      glibtoolize
else
    check_header       libarchive   archive.h
    check_header       libssl       openssl/ssl.h
    check_header       readline     readline.h readline/readline.h
    check_program      libtoolize
fi

if [ ${#missing_depends[@]} -ne 0 ]; then
    echo "Couldn't find dependencies:"
    for dep in "${missing_depends[@]}"; do
        echo "  - $dep"
    done
	exit 1
fi

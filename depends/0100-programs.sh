#!/bin/sh

. ../depends.sh

# Code downloaders
check_program   git		Git		'https://git-scm.com/'
check_program   svn		Subversion	'https://subversion.apache.org/'
check_program   wget		'GNU wget'	'https://www.gnu.org/software/wget/'

# Archivers
check_program   tar		'GNU tar'	'https://www.gnu.org/software/tar/'

# Code manipulation
check_program   patch		'GNU patch'	'https://www.gnu.org/software/patch/'

# Build systems
check_program   autoconf	'GNU Autoconf'	'https://www.gnu.org/software/autoconf/'
check_program   automake	'GNU Automake'	'https://www.gnu.org/software/automake/'
check_program   cmake		'CMake'		'https://cmake.org/'
check_program   make		'GNU make'	'https://www.gnu.org/software/make/'

# Compilers
# We use generic names but try to recommend GCC
check_program   cc		'GNU GCC'	'https://gcc.gnu.org/'
check_program   c++		'GNU GCC'	'https://gcc.gnu.org/'

check_program   bison		'GNU Bison'	'https://www.gnu.org/software/bison/'
check_program   flex		'GNU Flex'	'https://www.gnu.org/software/flex/'
check_program   tclsh		'Tcl'		'https://www.tcl.tk/'

check_program   makeinfo	'GNU Texinfo'	'https://www.gnu.org/software/texinfo/'
check_program   doxygen		'Doxygen'	'http://www.doxygen.org/'

# On macOS, 
if [ "x$(uname)" = "xDarwin" ]; then
    check_program      glibtoolize	'GNU Libtool'	'https://www.gnu.org/software/libtool/'
else
    check_program      libtoolize	'GNU Libtool'	'https://www.gnu.org/software/libtool/'
fi

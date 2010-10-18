#!/bin/sh
# check-mpfr.sh by Dan Peori (danpeori@oopo.net)

 ## Check for the mpfr library.
 ls /usr/include/mpfr.h 1> /dev/null || { echo "ERROR: Install mpfr before continuing."; exit 1; }

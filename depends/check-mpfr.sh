#!/bin/sh
# check-mpfr.sh by Dan Peori (danpeori@oopo.net)

## Check for the mpfr library.
ls /usr/include/mpfr.h > /dev/null 2>&1 || \
ls /usr/local/include/mpfr.h > /dev/null 2>&1 || \
ls /opt/include/mpfr.h > /dev/null 2>&1 || \
ls /opt/local/include/mpfr.h > /dev/null 2>&1 || \
{ echo "ERROR: Install mpfr before continuing."; exit 1; }


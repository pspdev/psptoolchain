#!/bin/sh
# check-gmp.sh by Dan Peori (danpeori@oopo.net)

## Check for the gmp library.
ls /usr/include/gmp.h > /dev/null 2>&1 || \
ls /usr/local/include/gmp.h > /dev/null 2>&1 || \
ls /opt/include/gmp.h > /dev/null 2>&1 || \
ls /opt/local/include/gmp.h > /dev/null 2>&1 || \
ls /usr/include/x86_64-linux-gnu/gmp.h > /dev/null 2>&1 || \
ls /usr/local/include/x86_64-linux-gnu/gmp.h > /dev/null 2>&1 || \
ls /usr/include/i386-linux-gnu/gmp.h > /dev/null 2>&1 || \
ls /usr/local/include/i386-linux-gnu/gmp.h > /dev/null 2>&1 || \
{ echo "ERROR: Install gmp before continuing."; exit 1; }


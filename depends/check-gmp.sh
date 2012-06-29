#!/bin/sh
# check-gmp.sh by Dan Peori (danpeori@oopo.net)

 ## Check for the gmp library.
 ls /usr/include/gmp.h 1> /dev/null || \
 ls /usr/local/include/gmp.h 1> /dev/null || \
 ls /opt/include/gmp.h 1> /dev/null || \
 ls /opt/local/include/gmp.h 1> /dev/null || \
 { echo "ERROR: Install gmp before continuing."; exit 1; }

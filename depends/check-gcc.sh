#!/bin/sh
# check-gcc.sh by Dan Peori (danpeori@oopo.net)

## Check for gcc.
gcc --version > /dev/null 2>&1 || { echo "ERROR: Install gcc before continuing."; exit 1; }


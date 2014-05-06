#!/bin/sh
# check-make.sh by Dan Peori (danpeori@oopo.net)

## Check for make.
make -v > /dev/null 2>&1 || { echo "ERROR: Install make before continuing."; exit 1; }


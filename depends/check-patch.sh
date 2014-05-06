#!/bin/sh
# check-patch.sh by Dan Peori (danpeori@oopo.net)

## Check for patch.
patch -v > /dev/null 2>&1 || { echo "ERROR: Install patch before continuing."; exit 1; }


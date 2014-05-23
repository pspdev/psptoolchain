#!/bin/sh
# check-autoconf.sh by Dan Peori (danpeori@oopo.net)

## Check for autoconf.
autoconf --version > /dev/null 2>&1 || { echo "ERROR: Install autoconf before continuing."; exit 1; }


#!/bin/sh
# check-autoconf.sh by Dan Peori (danpeori@oopo.net)

 ## Check for autoconf.
 autoconf --version 1> /dev/null || { echo "ERROR: Install autoconf before continuing."; exit 1; }

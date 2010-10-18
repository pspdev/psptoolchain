#!/bin/sh
# check-make.sh by Dan Peori (danpeori@oopo.net)

 ## Check for make.
 make -v 1> /dev/null || { echo "ERROR: Install make before continuing."; exit 1; }

#!/bin/sh
# check-automake.sh by Dan Peori (danpeori@oopo.net)

## Check for automake.
automake --version > /dev/null 2>&1 || { echo "ERROR: Install automake before continuing."; exit 1; }


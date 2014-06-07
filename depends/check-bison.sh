#!/bin/sh
# check-bison.sh by Dan Peori (danpeori@oopo.net)

## Check for bison.
bison --version > /dev/null 2>&1 || { echo "ERROR: Install bison before continuing."; exit 1; }


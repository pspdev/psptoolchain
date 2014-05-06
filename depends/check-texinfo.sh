#!/bin/sh
# check-texinfo.sh by Dan Peori (danpeori@oopo.net)

## Check for texinfo.
makeinfo --version > /dev/null 2>&1 || { echo "ERROR: Install texinfo before continuing."; exit 1; }


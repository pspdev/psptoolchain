#!/bin/sh
# check-texinfo.sh by Dan Peori (danpeori@oopo.net)

 ## Check for texinfo.
 makeinfo --version 1> /dev/null || { echo "ERROR: Install texinfo before continuing."; exit 1; }

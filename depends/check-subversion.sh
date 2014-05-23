#!/bin/sh
# check-subversion.sh by Dan Peori (danpeori@oopo.net)

## Check for subversion.
svn help > /dev/null 2>&1 || { echo "ERROR: Install subversion before continuing."; exit 1; }


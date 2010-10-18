#!/bin/sh
# check-subversion.sh by Dan Peori (danpeori@oopo.net)

 ## Check for subversion.
 svn help 1> /dev/null || { echo "ERROR: Install subversion before continuing."; exit 1; }

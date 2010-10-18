#!/bin/sh
# check-wget.sh by Dan Peori (danpeori@oopo.net)

 ## Check for wget.
 wget -V 1> /dev/null || { echo "ERROR: Install wget before continuing."; exit 1; }

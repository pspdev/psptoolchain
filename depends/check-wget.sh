#!/bin/sh
# check-wget.sh by Dan Peori (danpeori@oopo.net)

## Check for wget.
wget -V > /dev/null 2>&1 || { echo "ERROR: Install wget before continuing."; exit 1; }


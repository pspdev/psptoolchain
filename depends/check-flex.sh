#!/bin/sh
# check-flex.sh by Dan Peori (danpeori@oopo.net)

## Check for flex.
flex --version > /dev/null 2>&1 || { echo "ERROR: Install flex before continuing."; exit 1; }


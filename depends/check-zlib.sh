#!/bin/sh
# check-ncurses.sh by Dan Peori (danpeori@oopo.net)
# check-zlib.sh by Sam Hegarty (hegarty.sam@gmail.com)

## Check for the z library.
ls /usr/include/zlib.h > /dev/null 2>&1 ||
ls /usr/local/include/zlib.h > /dev/null 2>&1 ||
ls /opt/local/include/zlib.h > /dev/null 2>&1 ||
{ echo "ERROR: Install zlib before continuing."; exit 1; }


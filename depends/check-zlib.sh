#!/bin/sh
# check-ncurses.sh by Dan Peori (danpeori@oopo.net)
# check-zlib.sh by Sam Hegarty (hegarty.sam@gmail.com)

 ## Check for the z library.
 ls /usr/include/zlib.h 1> /dev/null ||
 ls /usr/local/include/zlib.h 1> /dev/null ||
 { echo "ERROR: Install zlib before continuing."; exit 1; }

#!/bin/sh
# check-ncurses.sh by Dan Peori (danpeori@oopo.net)

 ## Check for the ncurses library.
 ls /usr/include/ncurses.h 1> /dev/null || { echo "ERROR: Install ncurses before continuing."; exit 1; }

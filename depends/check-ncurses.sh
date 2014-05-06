#!/bin/sh
# check-ncurses.sh by Dan Peori (danpeori@oopo.net)

## Check for the ncurses library.
ls /usr/include/ncurses.h > /dev/null 2>&1 ||
ls /usr/include/ncurses/ncurses.h > /dev/null 2>&1 ||
ls /usr/local/include/ncurses.h > /dev/null 2>&1 ||
ls /opt/local/include/ncurses.h > /dev/null 2>&1 ||
{ echo "ERROR: Install ncurses before continuing."; exit 1; }


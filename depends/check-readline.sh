#!/bin/sh
# check-readline.sh by Dan Peori (danpeori@oopo.net)

 ## Check for the readline library.
 ls /usr/include/readline/readline.h 1> /dev/null || { echo "ERROR: Install readline before continuing."; exit 1; }

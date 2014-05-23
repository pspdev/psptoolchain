#!/bin/sh
# check-readline.sh by Dan Peori (danpeori@oopo.net)

## Check for the readline library.
ls /usr/include/readline/readline.h > /dev/null 2>&1 || \
ls /usr/local/include/readline/readline.h > /dev/null 2>&1 || \
ls /opt/local/include/readline/readline.h > /dev/null 2>&1 || \
{ echo "ERROR: Install readline before continuing."; exit 1; }


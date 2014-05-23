#!/bin/sh
# check-mpc.sh by yreeen (yreeen@gmail.com)

## Check for the mpc library.
ls /usr/include/mpc.h > /dev/null 2>&1 || \
ls /usr/local/include/mpc.h > /dev/null 2>&1 || \
ls /opt/include/mpc.h > /dev/null 2>&1 || \
ls /opt/local/include/mpc.h > /dev/null 2>&1 || \
{ echo "ERROR: Install mpc before continuing."; exit 1; }


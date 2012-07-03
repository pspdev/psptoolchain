#!/bin/sh
# check-mpc.sh by yreeen (yreeen@gmail.com)

 ## Check for the mpc library.
 ls /usr/include/mpc.h 1> /dev/null || \
 ls /usr/local/include/mpc.h 1> /dev/null || \
 ls /opt/include/mpc.h 1> /dev/null || \
 ls /opt/local/include/mpc.h 1> /dev/null || \
 { echo "ERROR: Install mpc before continuing."; exit 1; }

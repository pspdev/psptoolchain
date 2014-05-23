#!/bin/sh
# check-elf.sh by SamRH (samr.hegarty@gmail.com)

## Check for the libelf library.
ls /usr/include/gelf.h > /dev/null 2>&1 || \
ls /usr/include/libelf.h > /dev/null 2>&1 || \
ls /usr/local/include/libelf/libelf.h > /dev/null 2>&1 || \
ls /usr/local/include/gelf.h > /dev/null 2>&1 || \
ls /usr/local/include/libelf.h > /dev/null 2>&1 || \
ls /opt/include/gelf.h > /dev/null 2>&1 || \
ls /opt/include/libelf.h > /dev/null 2>&1 || \
ls /opt/local/include/gelf.h > /dev/null 2>&1 || \
ls /opt/local/include/libelf.h > /dev/null 2>&1 || \
ls /opt/local/include/libelf/gelf.h > /dev/null 2>&1 || \
ls /opt/local/include/libelf/libelf.h > /dev/null 2>&1 || \
{ echo "ERROR: Install elf before continuing."; exit 1; }


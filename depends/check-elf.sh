#!/bin/sh
# check-elf.sh by yreeen (yreeen@gmail.com)

## Check for the elf library.
ls /usr/include/elf.h > /dev/null 2>&1 || \
ls /usr/local/include/elf.h > /dev/null 2>&1 || \
ls /usr/local/include/libelf/libelf.h > /dev/null 2>&1 || \
ls /opt/include/libelf/libelf.h > /dev/null 2>&1 || \
ls /opt/local/include/libelf/libelf.h > /dev/null 2>&1 || \
{ echo "ERROR: Install elf before continuing."; exit 1; }


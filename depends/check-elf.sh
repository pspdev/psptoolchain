#!/bin/sh
# check-elf.sh by yreeen (yreeen@gmail.com)

 ## Check for the elf library.
 ls /usr/include/elf.h 1> /dev/null || \
 ls /usr/local/include/elf.h 1> /dev/null || \
 ls /usr/local/include/libelf/libelf.h 1> /dev/null || \
 ls /opt/include/libelf/libelf.h 1> /dev/null || \
 ls /opt/local/include/libelf/libelf.h 1> /dev/null || \
  { echo "ERROR: Install elf before continuing."; exit 1; }

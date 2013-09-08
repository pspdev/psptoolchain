#!/bin/sh
# check-elf.sh by SamRH (samr.hegarty@gmail.com)

 ## Check for the libelf library.
 ls /usr/include/gelf.h 1> /dev/null || \
 ls /usr/include/libelf.h 1> /dev/null || \
 ls /usr/local/include/libelf/libelf.h 1> /dev/null || \
 ls /usr/local/include/gelf.h 1> /dev/null || \
 ls /usr/local/include/libelf.h 1> /dev/null || \
 ls /opt/include/gelf.h 1> /dev/null || \
 ls /opt/include/libelf.h 1> /dev/null || \
 ls /opt/local/include/gelf.h 1> /dev/null || \
 ls /opt/local/include/libelf.h 1> /dev/null || \
 ls /opt/local/include/libelf/gelf.h 1> /dev/null || \
 ls /opt/local/include/libelf/libelf.h 1> /dev/null || \
  { echo "ERROR: Install elf before continuing."; exit 1; }

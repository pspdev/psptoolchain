#!/bin/sh
# check-pspdev.sh by Naomi Peori (naomi@peori.ca)

## Check if $PSPDEV is set.
if test ! $PSPDEV; then { echo "ERROR: Set \$PSPDEV before continuing."; exit 1; } fi

## Check for the $PSPDEV directory.
ls -ld $PSPDEV > /dev/null 2>&1 || mkdir -p $PSPDEV > /dev/null 2>&1 || { echo "ERROR: Create $PSPDEV before continuing."; exit 1; }

## Check for write permission.
touch $PSPDEV/test.tmp > /dev/null 2>&1 || { echo "ERROR: Grant write permissions for $PSPDEV before continuing."; exit 1; }

## Check for $PSPDEV/bin in the path.
echo $PATH | grep $PSPDEV/bin > /dev/null 2>&1 || { echo "ERROR: Add $PSPDEV/bin to your path before continuing."; exit 1; }


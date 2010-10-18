#!/bin/sh
# check-pspdev.sh by Dan Peori (danpeori@oopo.net)

 ## Check if $PSPDEV is set.
 if test ! $PSPDEV; then { echo "ERROR: Set \$PSPDEV before continuing."; exit 1; } fi

 ## Check for the $PSPDEV directory.
 ls -ld $PSPDEV 1> /dev/null || mkdir -p $PSPDEV 1> /dev/null || { echo "ERROR: Create $PSPDEV before continuing."; exit 1; }

 ## Check for write permission.
 touch $PSPDEV/test.tmp 1> /dev/null || { echo "ERROR: Grant write permissions for $PSPDEV before continuing."; exit 1; }

 ## Check for $PSPDEV/bin in the path.
 echo $PATH | grep $PSPDEV/bin 1> /dev/null || { echo "ERROR: Add $PSPDEV/bin to your path before continuing."; exit 1; }

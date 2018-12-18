#!/bin/sh
# 0000-pspdev-prefix.sh by Jakub Kaszycki
# Based on check-pspdev.sh by Naomi Peori (naomi@peori.ca)

error_byhand ()
{
	cat >&2 <<_EOF_
Error: do not call this script by hand!
Use one of the toolchain.sh scripts!
_EOF_
	exit 1
}

error_create ()
{
	cat >&2 <<_EOF_
Error: could not create installation prefix: $PSPDEV
Please create it yourself.
Note that this script needs to be run with permission to write into the prefix.
_EOF_
	exit 1
}

error_write ()
{
	cat >&2 <<_EOF_
Error: can not write to installation prefix: $PSPDEV
Please adjust its permissions.
_EOF_
	exit 1
}

# This script should not be run by hand, but only by toolchain.sh. Thus, we
# check a variable that is set by that script.
if test -z "$PSPDEV"
then
	error_byhand
fi

# Check whether $PSPDEV/bin is in the PATH.
# toolchain.sh does it.
if ! echo "$PATH" | grep -F "$PSPDEV/bin" > /dev/null 2>&1
then
	error_byhand
fi

# Check whether $PSPDEV exists.
# If not, create it.
if ! ([ -d "$PSPDEV" ] || mkdir -p "$PSPDEV" > /dev/null 2>&1; exit $?)
then
	error_create
fi

# Check whether we can create files in $PSPDEV.
if ! tee "$PSPDEV/test.tmp" </dev/null >/dev/null 2>&1
then
	error_write
fi

# Check whether we can dispose of files in $PSPDEV.
# Also dispose of a temporary file.
if ! rm -f "$PSPDEV/test.tmp" >/dev/null 2>&1
then
	error_write
fi

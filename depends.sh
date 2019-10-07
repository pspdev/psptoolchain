#!/bin/sh

fail ()
{
	exit 1
}

check_program ()
{
	if ! command -v "$1" >/dev/null 2>&1
	then
		cat >&2 <<_EOF_
Error: program $1 is missing.
It is a part of $2.
It can be downloaded from <$3>.
_EOF_
		fail
	fi
}

find_header_file ()
{
	if [ -z "$HEADER_LOC_LIST" ]
	then
		HEADER_LOC_LIST="$(cc -v -E - </dev/null 2>&1 | sed -n -e '/^#include "\.\.\." search starts here:$/,/^End of search list\.$/p' | grep '^ ' | sed -e 's|^ ||')"
	fi

	IFS_backup="$IFS"
	IFS='
'

	for DIR in $HEADER_LOC_LIST
	do
		if [ -f "$DIR/$1" ]
		then
			return 0
		fi
	done

	IFS="$IFS_backup"
	unset IFS_backup

	return 1
}

check_header ()
{
	printf "Checking for header %s... " "$1"

	cat >tmp.$$.c <<_EOF_
#include <stdio.h>
#include <$1>

int
main (void)
{
	return 0;
}
_EOF_

	if gcc -c -o tmp.$$.o tmp.$$.c >/dev/null 2>&1
	then
		rm -f tmp.$$.c tmp.$$.o
		echo "yes"
		return 0
	elif find_header_file "$1"
	then
		rm -f tmp.$$.c tmp.$$.o
		echo "present but cannot be compiled"
		return 99
	else
		rm -f tmp.$$.c tmp.$$.o
		echo "no"
		return 1
	fi
}

check_headers ()
{
	LIBRARY="$1"
	shift

	echo "Checking headers of $LIBRARY:"

	for HEADER
	do
		if ! check_header "$HEADER"
		then
			cat >&2 <<_EOF_
Error: missing header: $HEADER
This usually means that $LIBRARY is not installed or is misconfigured.
_EOF_
			fail
		fi
	done
}

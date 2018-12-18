#!/bin/sh
# toolchain.sh by Jakub Kaszycki <jakub@kaszycki.net.pl>

# This function is based on an old function, which enforced the number of
# jobs. Now the only purpose of this function is to provide a way to detect
# CPU number when the user wants to detect it.
num_cpus ()
{
	if command -v getconf >/dev/null 2>&1
	then
		if getconf _NPROCESSORS_ONLN >/dev/null 2>&1
		then
			getconf _NPROCESSORS_ONLN
			return 0
		fi
	fi

	cat >&2 <<_EOF_
Warning: could not detect number of CPUs, assuming 1 job at a time
_EOF_
	echo 1
}

# Parse the command line options.

short_usage ()
{
	echo "Usage: $0 [options...] [stages...]"
}

error_usage ()
{
	short_usage
	echo "Try $0 -h for more information."
}

usage ()
{
	short_usage
	cat <<_EOF_
Builds the PSP toolchain.

Options:

	-d<DIRECTORY>	Set <DIRECTORY> as the output directory.
			This option is required.
	-h		Print this help text.
	-j<JOBS>	Run <JOBS> jobs at the same time. If the argument
			"auto" is given, chooses a number depending on the
			number of available CPUs. If this option is not given,
			the script runs only one job at a time (takes
			a lot of time with tasks like building GCC, but is
			safer, more stable and much more deterministic).
	-s<DIRECTORY>	Set <DIRECTORY> as the source directory.
			The default is current directory.

If no stages are passed, all stages are run. Otherwise, only the selected
stages are run with the order as passed on the command line.

Stages may be passed as names, numbers or script names.
_EOF_
}

PSPDEV=
JOBS=1
SOURCE=.

while getopts '+:d:hj:s:' opt
do
	case "$opt" in
		d)
			PSPDEV="$OPTARG"
			;;
		h)
			usage
			exit 0
			;;
		j)
			JOBS="$OPTARG"
			;;
		s)
			SOURCE="$OPTARG"
			;;
		\?)
			echo "Unknown option: -$OPTOPT"
			error_usage >&2
			exit 2
			;;
		:)
			echo "Missing argument to option -$OPTOPT" >&2
			error_usage >&2
			exit 2
			;;
		*)
			echo 'Internal error' >&2
			exit 99
	esac
done

shift $((OPTIND-1))

if [ -z "$PSPDEV" ]
then
	echo "Missing required option -d"
	exit 2
fi

if [ "x$JOBS" = xauto ]
then
	JOBS="$(num_cpus)"
fi

PSPDEV="$(realpath "$PSPDEV")"
SOURCE="$(realpath "$SOURCE")"

PSPDEV_TMPDIR="$(mktemp -dt pspdev-tmp-XXXXXX)"

cleanup ()
{
	rm -rf "$PSPDEV_TMPDIR"
}

trap cleanup EXIT

export JOBS
export PSPDEV
export PSPDEV_TMPDIR

PATH="$PSPDEV/bin:$PATH"
export PATH

# Usage: run_script SCRIPT TYPE
run_script ()
{
	SCRIPT="$1"

	echo "Running $2 script: $(basename "$SCRIPT")"

	"$SCRIPT"
	X=$?

	if ! [ "$X" -eq 0 ]
	then
		echo "Script $(basename "$SCRIPT") failed with error $X"
		exit 1
	fi
}

# Usage: run_scripts DIR TYPE
run_scripts ()
{
	echo "Running $2 scripts"

	IFS_backup="$IFS"
	IFS='
'
	for SCRIPT in $(find "$1" -name '*.sh' | sort)
	do
		run_script "$SCRIPT" "$2"
	done
	IFS="$IFS_backup"
	unset IFS_backup
}

## Enter the psptoolchain directory.
cd "$SOURCE" || { echo "ERROR: Could not enter the psptoolchain directory."; exit 1; }

## Create the build directory.
mkdir -p build || { echo "ERROR: Could not create the build directory."; exit 1; }

## Enter the build directory.
cd build || { echo "ERROR: Could not enter the build directory."; exit 1; }

run_scripts ../depends dependency

get_script_number ()
{
	NUM="$1"
	NUM=$((NUM))
	printf '%03d' "$NUM"
	unset NUM
}

have_script_number ()
{
	# First, check it is a number
	if ! [ "$(printf "%s" "$1" | tr -d '0-9' | wc -c)" -eq 0 ]
	then
		return 1
	fi

	NUM="$(get_script_number "$1")"

	[ "$(find ../scripts -name "$NUM-*.sh" | wc -l)" -eq 1 ]
	return $?
}

have_script_name ()
{
	[ "$(find ../scripts -name "[0-9][0-9][0-9]-$1.sh" | wc -l)" -eq 1 ]
	return $?
}

if [ "$#" -eq 0 ]
then
	run_scripts ../scripts build
else
	for SCRIPT
	do
		if echo "$SCRIPT" | grep -F '/' >/dev/null 2>&1
		then
			# Plain file path.
			run_script "$(cd .. && realpath "$SCRIPT")" build
		elif [ -e "../scripts/$SCRIPT" ]
		then
			# Script file name
			run_script "../scripts/$SCRIPT" build
		elif have_script_number "$SCRIPT"
		then
			# Script number
			run_script "../scripts/$(get_script_number "$SCRIPT")-"*".sh" build
		elif have_script_name "$SCRIPT"
		then
			# Script name
			run_script "../scripts/"*"-$SCRIPT.sh" build
		else
			echo "Unknown script: $SCRIPT" >&2
			exit 1
		fi
	done
fi

#!/bin/sh

# Run the tar command.
# Usage: run_tar <directory> <tar options...>
run_tar ()
{
	DIRECTORY="$1"
	shift

	tar --directory="$DIRECTORY" --no-same-owner --strip-components=1 "$@"
}

# Extracts a file based on its extension
# Usage: extract <archive> <directory>
auto_extract ()
{
	FILE="$1"
	NAME="$(echo "$FILE" | sed -e 's|^.*/||')"
	EXTENSION="$(echo "$NAME" | sed -e 's|.*\.||')"
	DIRECTORY="$2"

	if [ -d "$DIRECTORY" ]
	then
		echo "Deleting existing $DIRECTORY"
		rm -rf "$DIRECTORY"
	fi

	mkdir -p "$DIRECTORY"

	echo "Extracting $NAME"

	case "$EXTENSION" in
		tar)
			run_tar "$DIRECTORY" -xf "$FILE"
			;;
		gz | tgz)
			run_tar "$DIRECTORY" -xzf "$FILE"
			;;
		bz2 | tbz2)
			run_tar "$DIRECTORY" -xjf "$FILE"
			;;
		xz | txz)
			run_tar "$DIRECTORY" -xJf "$FILE"
			;;
		*)
			cat >&2 <<_EOF_
Unsupported archive type: $EXTENSION
_EOF_
			 return 1
			 ;;
	esac

	return $?
}

# Downloads and extracts a file, with some extra checks.
# Usage: download_and_extract <url> <output directory>
download_and_extract ()
{
	URL="$1"
	NAME="$(echo "$URL" | sed -e 's|^.*/||;s|\?.*$||')"
	OUT_DIR="$2"

	# First, if the archive already exists, attempt to extract it. Failing
	# that, attempt to continue an interrupted download. If that also fails,
	# remove the presumably corrupted file.
	if [ -f "$NAME" ]
	then
		if auto_extract "$NAME" "$OUT_DIR"
		then
			return 0
		else
			wget --continue --no-check-certificate "$URL" -O "$NAME" || rm -f "$NAME"
		fi
	fi

	# If the file does not exist at this point, it means it was either never
	# downloaded, or it was deleted for being corrupted. Just go ahead and
	# download it.
	# Using wget --continue here would make buggy servers flip out for nothing.
	if ! [ -f "$NAME" ]
	then
		wget --no-check-certificate "$URL" -O "$NAME" || return 1
	fi

	auto_extract "$NAME" "$OUT_DIR"
}

# Runs Git in a way that won't lock waiting for the user or anything.
# Usage: git_noninteractive <normal git args...>
git_noninteractive ()
{
	SSH_ASKPASS=false git "$@" </dev/null
}

# Clones or updates a Git repository.
# Usage: clone_git_repo <url> <dir> [branch]
clone_git_repo ()
{
	URL="$1"
	LOCAL_DIR="$2"
	BRANCH="${3:-master}"
	
	# It is possible that this is an actual copy of the repository we are
	# interested in.
	if [ -d "$LOCAL_DIR/.git" ] \
		&& git_noninteractive -C "$LOCAL_DIR" status >/dev/null 2>&1 \
		&& [ "x$(git_noninteractive -C "$LOCAL_DIR" remote get-url origin 2>/dev/null)" = "x$URL" ]
	then
		echo "Updating existing repository in $LOCAL_DIR"
		cd "$LOCAL_DIR" || return 1
		git_noninteractive pull --rebase origin "$BRANCH" || return 1
		git_noninteractive reset --hard || return 1
		git_noninteractive clean -dfx || return 1
		cd - >/dev/null 2>&1 || return 1
		return 0
	else
		echo "Deleting existing $LOCAL_DIR"
		rm -rf "$LOCAL_DIR"
	fi

	git_noninteractive clone --recursive --depth 1 -b "$BRANCH" "$URL" "$LOCAL_DIR" || return 1
}

# Runs make with our options.
# Usage: run_make <normal make args...>
run_make ()
{
	make -j"$JOBS" "$@"
}

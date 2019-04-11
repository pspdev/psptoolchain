#!/bin/sh

case "$(uname -s)" in
	Linux)

		if command -v apt >/dev/null 2>&1
		then
			if ! [ "$(id -u "$USER")" -eq 0 ]
			then
				cat >&2 <<_EOF_
Warning: running without superuser privileges
THIS IS MOST LIKELY GOING TO FAIL.
Run this script using sudo, su or pkexec.
_EOF_
			fi

			set -e

			echo 'Installing dependency packages using APT...'
			apt install \
				autoconf \
				automake \
				bison \
				build-essential \
				bzip2 \
				ca-certificates \
				cmake \
				doxygen \
				flex \
				gcc \
				git \
				gzip \
				g++ \
				libelf-dev \
				libfreetype6-dev \
				libncurses-dev \
				libreadline-dev \
				libusb-dev \
				libtool \
				subversion \
				tcl \
				texinfo \
				wget \
				xz-utils \
				zlib1g-dev
		elif command -v apt-get >/dev/null
		then
			if ! [ "$(id -u "$USER")" -eq 0 ]
			then
				cat >&2 <<_EOF_
Warning: running without superuser privileges
THIS IS MOST LIKELY GOING TO FAIL.
Run this script using sudo, su or pkexec.
_EOF_
			fi

			set -e

			echo 'Installing dependency packages using legacy APT...'
			apt-get install \
				autoconf \
				automake \
				automake1.9 \
				bison \
				build-essential \
				bzip2 \
				cmake \
				doxygen \
				flex \
				gcc \
				git \
				gzip \
				g++ \
				libelf-dev \
				libfreetype6-dev \
				libncurses5-dev \
				libreadline-dev \
				libusb-dev \
				libtool \
				subversion \
				tcl \
				texinfo \
				xz-utils \
				zlib1g-dev
		elif command -v dnf >/dev/null 2>&1
		then
			cat >&2 <<_EOF_
Error: DNF is not supported yet
_EOF_
			exit 77
		elif command -v yum >/dev/null 2>&1
		then
			cat >&2 <<_EOF_
Error: YUM is not supported yet
_EOF_
			exit 77
		elif command -v pacman >/dev/null 2>&1
		then
			cat >&2 <<_EOF_
Error: pacman is not supported yet
_EOF_
			exit 77
		else
			cat >&2 <<_EOF_
Error: your Linux distribution uses an unknown package manager or doesn't have one.
_EOF_
			exit 77
		fi
		;;
	Darwin)
		LIBUSB_URL='https://downloads.sourceforge.net/project/libusb/libusb-0.1%20%28LEGACY%29/0.1.12/libusb-0.1.12.tar.gz'

		cleanup_libusb ()
		{
			echo 'Cleaning up libUSB...'

			rm -rf libusb-legacy libusb-legacy.tar.gz
		}

		download_libusb ()
		{
			echo 'Downloading libUSB (legacy version)...'

			if command -v wget >/dev/null 2>&1
			then
				wget --continue -O libusb-legacy.tar.gz "$LIBUSB_URL"
			elif command -v curl >/dev/null 2>&1
			then
				curl --continue-at - -o libusb-legacy.tar.gz "$LIBUSB_URL"
			else
				cat >&2 <<_EOF_
Error: no suitable downloader found.

Install one of these:

  * wget (preferred) <https://www.gnu.org/software/wget/>
  * curl <https://curl.haxx.se/>
_EOF_
				exit 77
			fi
		}

		build_libusb ()
		{
			echo 'Configuring libUSB (legacy version)...'
			mkdir build
			cd build
			../configure CFLAGS='-Wno-error' CPPFLAGS='-Wno-error'
			echo 'Building libUSB (legacy version)...'
			make
			echo 'Installing libUSB (legacy version)...'
			make install
			cd ..
		}

		install_libusb ()
		{
			cleanup_libusb
			download_libusb
			echo 'Unpacking libUSB (legacy version)...'
			mkdir libusb-legacy
			tar --directory=libusb-legacy --strip-components=1 -zxf libusb-legacy.tar.gz
			build_libusb
			cd libusb-legacy
			cd ..
			cleanup_libusb
		}

		if command -v port >/dev/null 2>&1
		then
			if ! [ "$(id -u "$USER")" -eq 0 ]
			then
				cat >&2 <<_EOF_
Warning: running without superuser privileges
THIS IS MOST LIKELY GOING TO FAIL.
Run this script using sudo or su.
_EOF_
			fi

			set -e

			echo 'Installing libELF...'
			port install libelf
			echo 'Installing libUSB...'
			port install libusb
			echo 'Installing wget...'
			port install wget
			echo 'Installing xz...'
			port install xz

			install_libusb
		elif command -v brew >/dev/null 2>&1
		then
			# We are using /usr/bin/stat because otherwise a GNU stat from
			# Homebrew may get pulled in which is incompatible.
			if ! [ "$(id -u "$USER")" -eq "$(/usr/bin/stat -f'%u' "$(brew --cellar)")" ]
			then
				cat >&2 <<_EOF_
Warning: you are not the owner of Homebrew.
THIS IS MOST LIKELY GOING TO FAIL.
Run this script using sudo or su, or contact the owner of Homebrew.
_EOF_
			fi

			echo 'Installing libELF...'
			brew install libelf
			echo 'Installing libUSB...'
			brew install libusb
			echo 'Installing libUSB (legacy version)...'
			brew install libusb-compat
			echo 'Installing wget...'
			brew install wget
			echo 'Installing xz...'
			brew install xz
		else
			cat >&2 <<_EOF_
No suitable package manager detected!

The following package managers are supported on macOS:

  * Homebrew <https://brew.sh/>
  * MacPorts <https://macports.org/>
_EOF_
			exit 77
		fi
		;;
	*)
		cat >&2 <<_EOF_
Error: your operating system is not supported.
_EOF_
		exit 77
esac

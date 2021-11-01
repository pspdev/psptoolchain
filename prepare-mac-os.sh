#!/bin/sh

# only needed for macports
install_libusb() {
	wget --continue https://downloads.sourceforge.net/project/libusb/libusb-0.1%20%28LEGACY%29/0.1.12/libusb-0.1.12.tar.gz -O libusb-legacy.tar.gz
	rm -Rf libusb-legacy && mkdir libusb-legacy && tar --strip-components=1 --directory=libusb-legacy -xzf libusb-legacy.tar.gz
	cd libusb-legacy
	./configure && make CFLAGS="-Wno-error" CPPFLAGS="-Wno-error" && make install
	cd ../
	rm -Rf libusb-legacy && rm libusb-legacy.tar.gz
}

show_help() {
	echo "Use '-b' or '--brew' to install packages with Homebrew, or use '-p' or '--port' to install with MacPorts."
	echo "If left unspecified, tries Homebrew first, then MacPorts."
	exit $(false)
}

if [ $# -gt 1 ]; then
	echo "Invalid number of command line options."
	show_help
fi

# default is autodetection
try_brew=$(true)
try_port=$(true)
if [ $# -eq 1 ]; then
	case "$1" in
	-b|--brew)
		try_port=$(false) ;;
	-p|--port)
		try_brew=$(false) ;;
	*)
		show_help ;;
	esac
fi

if ! [ -e "/usr/local/bin/brew" -o -e "/opt/local/bin/port" ]; then
	echo "Go install Homebrew from http://brew.sh/ or MacPorts from http://www.macports.org/ first, then we can talk!"
	exit $(false)
fi

# sanity checks
if [ $try_brew -eq $(true) -a ! -e "/usr/local/bin/brew" ]; then
	echo "Not trying Homebrew, because it is not installed."
	try_brew=$(false)
fi
if [ $try_port -eq $(true) -a ! -e "/opt/local/bin/port" ]; then
	echo "Not trying MacPorts, because it is not installed."
	try_port=$(false)
fi
if [ $try_brew -eq $(false) -a $try_port -eq $(false) ]; then
	echo "Invalid package manager specified. Maybe use autodetection."
	exit $(false)
fi

# actual installation
if [ $try_brew -eq $(true) ]; then
	CURRENT_USER=$(stat -f '%Su' /dev/console)
	sudo -u $CURRENT_USER brew install autoconf automake cmake doxygen gnu-sed libelf libtool libusb libusb-compat pkg-config wget xz
	exit $(true)
fi
if [ $try_port -eq $(true) ]; then
	sudo port install autoconf automake cmake doxygen gsed libelf libtool libusb pkgconfig wget xz

	install_libusb
	exit $(true)
fi

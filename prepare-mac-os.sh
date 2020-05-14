#!/bin/sh

install_libusb() {
	wget --continue https://downloads.sourceforge.net/project/libusb/libusb-0.1%20%28LEGACY%29/0.1.12/libusb-0.1.12.tar.gz -O libusb-legacy.tar.gz
	rm -Rf libusb-legacy && mkdir libusb-legacy && tar --strip-components=1 --directory=libusb-legacy -xzf libusb-legacy.tar.gz
	cd libusb-legacy
	./configure && make CFLAGS="-Wno-error" CPPFLAGS="-Wno-error" && make install
	cd ../
	rm -Rf libusb-legacy && rm libusb-legacy.tar.gz
}
brew() {
	CURRENT_USER=$(stat -f '%Su' /dev/console)
	sudo -u $CURRENT_USER brew install brew install autoconf automake cmake doxygen gnu-sed libelf libool libusb libusb-compat pkg-config wget xz
}
ports() {
	sudo port install autoconf automake cmake doxygen gsed libelf libtool libusb pkgconfig wget xz
	install_libusb
}

if [ "$1" == "-b" ] || [ "$1" == "--brew" ]; then # Homebrew flag
	brew()
elif [ "$1" == "-p" ] || [ "$1" == "--port" ]; then # MacPorts flag
	ports()
elif [ "$1" == "-h" ] || [ "$1" == "--help" ]; then # Help
	echo "Use '-b' or '--brew' to install packages with Homebrew, or use '-p' or '--port' to install with MacPorts."
else # no flag
	if [ -e "/usr/local/bin/brew" ]; then
		brew()
	elif [ -e "/opt/local/bin/port" ]; then
		ports()
	else
		echo "Go install MacPorts from http://www.macports.org/ or Homebrew from http://brew.sh/ first, then we can talk"
	fi
fi
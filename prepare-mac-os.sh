#!/bin/sh

install_libusb() {
	wget --continue https://downloads.sourceforge.net/project/libusb/libusb-0.1%20%28LEGACY%29/0.1.12/libusb-0.1.12.tar.gz -O libusb-legacy.tar.gz
	rm -Rf libusb-legacy && mkdir libusb-legacy && tar --strip-components=1 --directory=libusb-legacy -xzf libusb-legacy.tar.gz
	cd libusb-legacy
	./configure && make CFLAGS="-Wno-error" CPPFLAGS="-Wno-error" && make install
	cd ../
	rm -Rf libusb-legacy && rm libusb-legacy.tar.gz
}

if [ -e "/opt/local/bin/port" ]; then
	sudo port install wget
	sudo port install libelf
	sudo port install libmpc
	sudo port install libusb
	
	install_libusb
elif [ -e "/usr/local/bin/brew" ]; then
	CURRENT_USER=$(stat -f '%Su' /dev/console)
	sudo -u $CURRENT_USER brew install wget
	sudo -u $CURRENT_USER brew install libelf
	sudo -u $CURRENT_USER brew install libmpc
	sudo -u $CURRENT_USER brew install libusb

	sudo -u $CURRENT_USER brew install libusb-compat
else
	echo "Go install MacPorts from http://www.macports.org/ or Homebrew from http://brew.sh/ first, then we can talk"
fi


#!/bin/sh

install_libusb() {
	wget --continue http://downloads.sourceforge.net/project/libusb/libusb-0.1%20%28LEGACY%29/0.1.12/libusb-0.1.12.tar.gz -O libusb-legacy.tar.gz
	rm -Rf libusb-legacy && mkdir libusb-legacy && tar --strip-components=1 --directory=libusb-legacy -xzf libusb-legacy.tar.gz
	cd libusb-legacy
	./configure && make && make install
	cd ../
	rm -Rf libusb-legacy && rm libusb-legacy.tar.gz
}

if [ -e "/opt/local/bin/port" ]; then
	sudo port install wget
	sudo port install libelf
	sudo port install libmpc
	sudo port install libusb
	
	install_libusb()
elif [ -e "/usr/local/bin/brew" ]; then
	brew install wget
	brew install libelf
	brew install libmpc
	brew install libusb
	
	install_libusb()
else
	echo "Go install MacPorts from http://www.macports.org/ or Homebrew from http://brew.sh/ first, then we can talk"
fi


#!/bin/sh

if [ -e "/opt/local/bin/port" ]; then
	sudo port install wget
	sudo port install libelf
	sudo port install libmpc
	sudo port install libusb
	
	wget --continue http://downloads.sourceforge.net/project/libusb/libusb-0.1%20%28LEGACY%29/0.1.12/libusb-0.1.12.tar.gz?r=http%3A%2F%2Fsourceforge.net%2Fprojects%2Flibusb%2Ffiles%2Flibusb-0.1%2520%2528LEGACY%2529%2F0.1.12%2F&ts=1340988823&use_mirror=voxel -O libusb-legacy.tar.gz
	rm -Rf libusb-legacy && mkdir libusb-legacy && tar --strip-components=1 --directory=psplinkusb -xzf libusb-legacy.tar.gz
	cd libusb-legacy
	./configure && make && make install
	cd ../
	rm -Rf libusb-legacy && rm libusb-legacy.tar.gz
else
	echo "Go install MacPorts from http://www.macports.org/ first, then we can talk"
fi

#!/bin/sh

set -e

if [ -d /etc/profile.d/ ] && [ "$(id -u)" -eq "0" ];
then
	echo "export PSPDEV=$PSPDEV" > /etc/profile.d/psptoolchain.sh
	echo "export PATH=\$PATH:\$PSPDEV/bin" >> /etc/profile.d/psptoolchain.sh
	echo "$PSPDEV/bin added to your systems login scripts!"
else
	echo "Remember to add $PSPDEV/bin to your path..."
fi

#!/bin/bash

SH_PATH=$(which sh)
if ls -l $SH_PATH|grep dash >/dev/null 2>&1; then
    echo "--------------------------------------------------------------------------------"
    echo "ERROR: $SH_PATH is a symlink to dash!"
    echo ""
    echo "This does not go well with libtool, and will make compilation of some packages"
    echo "from psplibraries fail to compile."
    echo ""
    echo "On Debian-derived distros (including Ubuntu), the following will disable dash,"
    echo "and make $SH_PATH fall back to bash:"
    echo ""
    echo '$ echo "dash dash/sh boolean false"|sudo debconf-set-selections'
    echo '$ sudo dpkg-reconfigure --frontend=noninteractive dash'
    echo ""
    echo "Replace 'boolean false' with 'boolean true' if you want to go back to dash."
    echo ""
    echo "The reason why dash is the default on some systems is that letting bash provide"
    echo "$SH_PATH makes all shell scripts start up slightly slower."
    echo "--------------------------------------------------------------------------------"
fi

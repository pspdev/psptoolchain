What does this do?
==================

This program will automatically build and install a compiler and other tools used in the creation of homebrew software for the Sony Playstation Portable handheld videogame system.

How do I use it?
==================

1. Set up your environment by installing the following software:

        autoconf, automake, bison, cmake, doxygen, flex, g++/gcc-c++, gcc, git, gmp, libelf libusb-dev, make, mpfr, mpc, ncurses, patch, readline, subversion, texinfo, unzip, wget

2. Set the PSPDEV and PATH environmental variables:

        export PSPDEV=/usr/local/pspdev
        export PATH=$PATH:$PSPDEV/bin

    The PSPDEV variable is the directory the toolchain will be installed to, change this if you wish. If possible the toolchain script will automatically add these variables to your systems login scripts, otherwise you will need to manually add these variables yourself.

3. Run the toolchain script:

        ./toolchain.sh

> NOTE: If you have issues with compiling try increasing the amount of memory
> available to your system by creating a swapfile.
>
>     dd if=/dev/zero of=/swapfile bs=1M count=2048
>     chmod 600 /swapfile
>     mkswap /swapfile
>     swapon /swapfile
>
> After you are done use `swapoff -a` disable the swapfile. Finally you can
> remove it with `rm`.

Ubuntu
------

1. Install the required packages by running.

        sudo apt-get install autoconf automake bison cmake doxygen flex g++ gcc git libelf-dev libgmp-dev libmpfr-dev libncurses5-dev libreadline-dev libtool-bin libusb-dev make mpc patch subversion tcl texinfo unzip wget

2. Build and install the toolchain and SDK.

        sudo ./toolchain-sudo.sh
 
> NOTE: If you do not wish for the toolchain to be installed in /usr/local/pspdev then edit toolchain-sudo.sh and change the INSTALLDIR variable.

OSX
---

1. Install [`port`][MacPorts] or [`brew`][HomeBrew].
2. Run `prepare-mac-os.sh`. This will auto-install all the libraries you will need before building.
        
        sudo ./prepare-mac-os.sh

3. Build and install the toolchain and SDK.
        
        sudo ./toolchain-sudo.sh

Where do I go from here?
========================

Visit the following sites to learn more:

http://www.ps2dev.org
http://forums.ps2dev.org

[MacPorts]: http://www.macports.org/
[HomeBrew]: http://brew.sh/

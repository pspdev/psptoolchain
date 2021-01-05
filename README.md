What does this do?
==================

This program will automatically build and install a compiler and other tools
used in the creation of homebrew software for the Sony Playstation Portable
handheld videogame system.

How do I use it?
==================

1. Set up your environment by installing the following software:

        autoconf, automake, bison, bzip2, cmake, doxygen, diffutils, flex,
        g++/gcc-c++, gcc, git, gzip, libarchive, libcurl, libelf, libgpgme,
        libssl, libtool, libusb-dev, m4, make, ncurses, patch, pkg-config,
        python3, readline, subversion, tar, tcl, texinfo, unzip, wget, xz-utils

2. Set the PSPDEV and PATH environmental variables:

    ```shell
    export PSPDEV=/usr/local/pspdev
    export PATH=$PATH:$PSPDEV/bin
    ```

    The PSPDEV variable is the directory the toolchain will be installed to,
    change this if you wish. If possible the toolchain script will automatically
    add these variables to your systems login scripts, otherwise you will need
    to manually add these variables yourself.

3. Run the toolchain script:

        ./toolchain.sh

> NOTE: If you have issues with compiling try increasing the amount of
        memory available to your system by creating a swapfile.

```shell
dd if=/dev/zero of=/swapfile bs=1M count=2048
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile
[...compilation...]
swapoff /swapfile
rm /swapfile
```

Ubuntu/Debian
-------------

1. Install the required packages by running:

        sudo ./prepare-debian-ubuntu.sh

2. Build and install the toolchain and SDK.

        sudo ./toolchain-sudo.sh
 
    > NOTE: If you do not wish for the toolchain to be installed in
            `/usr/local/pspdev` then edit toolchain-sudo.sh and change the
            `$INSTALLDIR` variable.

OSX
---

1. Install [MacPorts][MacPorts] or [Homebrew][Homebrew].
2. Install all the libraries you will need before building by running:
        
        sudo ./prepare-mac-os.sh

    > NOTE: You can use `-b` or `--brew` flag for using Homebrew and
            `-p` or `--port` flag for using MacPorts.

3. Build and install the toolchain and SDK.
        
        sudo ./toolchain-sudo.sh

Where do I go from here?
========================

Visit the following sites to learn more:

[PSP-DEV Wiki](https://psp-dev.org/)

[PSP Homebrew Community Discord](https://discord.gg/bePrj9W)

[MacPorts]: http://www.macports.org/
[HomeBrew]: http://brew.sh/

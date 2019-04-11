What does this do?
==================

This program will automatically build and install a compiler and other tools used in the creation of homebrew software for the Sony Playstation Portable handheld videogame system.

Dependencies
============

PSP toolchain depends on the following packages:

```
autoconf, automake, bison, bzip2, flex, gcc, g++/gcc-c++, gzip, libusb-dev, make, ncurses, patch, readline, subversion, texinfo, xz-utils, wget, libelf git
```

Automatic dependency installation
---------------------------------

On both Linux and macOS, you can install the dependencies using a script:

```shell
sudo ./prepare.sh
```

This method is much easier than installing the packages manually and thus it's
the preferred method, especially for newcomers.

> NOTE: This script might fail. In such case you need to revert to manual
> installation as described above. Currently, the preparation script supports
> Linux with APT package manager (Debian, Ubuntu and derivatives)
> and macOS with [MacPorts](https://www.macports.org/) or
> [Homebrew](https://brew.sh).
>
> If you are using Homebrew, do not use ``sudo``.

Docker dependency installation
------------------------------

If you are using a Docker container or don't mind using one, you can use the
image ``topsekretpl/psptoolchain-ci`` from the Registry. It contains all
dependencies bundled into an upstream Debian installation. This is not
recommended for newcomers or people not accustomed with Docker.

If you want to build PSP toolchain in a docker image, do:

```shell
sudo docker pull topsekretpl/psptoolchain-ci:latest
sudo docker run --interactive --rm --tty <other options...> topsekretpl/psptoolchain-ci:latest /bin/bash -i -l
```

Note that this image does **not** contain PSP toolchain, solely the
dependencies.

Building
========

To build the toolchain and install it in ``/usr/local/pspdev``, run:

```shell
sudo ./toolchain-sudo.sh
```

Alternatively, there is another script that allows to install the toolchain in
a subdirectory of this repository:

```shell
./toolchain-local.sh
```

Both are wrappers around ``toolchain.sh`` which is slightly more sophisticated
but much more powerful.
 
> NOTE: If you do not wish for the toolchain to be installed in
> /usr/local/pspdev then edit run ``toolchain.sh`` manually. The ``-h`` option
> of ``toolchain.sh`` provides all necessary help.

> NOTE: If you have issues with compiling try increasing the amount of memory
> available to your system by creating a swapfile.
>
>     dd if=/dev/zero of=/swapfile bs=1M count=2048
>     chmod 600 /swapfile
>     mkswap /swapfile
>     swapon /swapfile
>
> After you are done use ``swapoff /swapfile`` to disable the swapfile. Then
> you should remove it with ``rm``.

Next steps
==========

Visit the following sites to learn more:

http://www.ps2dev.org
http://forums.ps2dev.org

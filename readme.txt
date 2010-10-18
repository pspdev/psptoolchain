 
 ====================
  What does this do?
 ====================

  This program will automatically build and install a compiler and other
  tools used in the creation of homebrew software for the Sony Playstation
  Portable handheld videogame system.

 ==================
  How do I use it?
 ==================

 1) Set up your environment by installing the following software:

  autoconf, automake, bison, flex, gcc, libusb-dev, make, ncurses,
  patch, readline, subversion, texinfo, wget

 2) Add the following to your login script:

  export PSPDEV=/usr/local/pspdev
  export PATH=$PATH:$PSPDEV/bin

 3) Run the toolchain script:

  ./toolchain.sh

 ==========================
  Where do I go from here?
 ==========================

  Visit the following sites to learn more:

   http://www.ps2dev.org
   http://forums.ps2dev.org

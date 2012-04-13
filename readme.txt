 
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

  autoconf, automake, bison, flex, gcc, g++/gcc-c++, libusb-dev, make, ncurses,
  patch, readline, subversion, texinfo, wget, mpc, gmp, libelf, mpfr, git

 2) Set the PSPDEV and PATH environmental variables:

  export PSPDEV=/usr/local/pspdev
  export PATH=$PATH:$PSPDEV/bin
  
  The PSPDEV variable is the directory the toolchain will be installed to, change 
  this if you wish. If possible the toolchain script will automatically add these 
  variables to your systems login scripts, otherwise you will need to manually add
  these variables yourself.

 3) Run the toolchain script:

  ./toolchain.sh

 ==========================
  Where do I go from here?
 ==========================

  Visit the following sites to learn more:

   http://www.ps2dev.org
   http://forums.ps2dev.org

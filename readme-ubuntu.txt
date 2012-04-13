
 ## Install the required packages.
 sudo apt-get install g++ build-essential autoconf automake bison flex \
  libncurses5-dev libreadline-dev libusb-dev texinfo libgmp3-dev   \
  libmpfr-dev libelf-dev libmpc-dev subversion git

 ## Build and install the toolchain + sdk. A login script will automatically 
 ## be created in /etc/profile.d/ if possible.
 sudo ./toolchain-sudo.sh
 
 NOTE: If you do not wish for the toolchain to be installed in /usr/local/pspdev
       then edit toolchain-sudo.sh and change the INSTALLDIR variable.

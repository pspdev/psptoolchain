
 ## Install the required packages.
 sudo apt-get install build-essential autoconf automake bison flex \
  libncurses5-dev libreadline-dev libusb-dev texinfo libgmp3-dev   \
  libmpfr-dev subversion

 ## Set up the environment.
 gedit ~/.bashrc

  ## Add these lines to the end of the file.
  export PSPDEV="/usr/local/pspdev"
  export PSPSDK="$PSPDEV/psp/sdk"
  export PATH="$PATH:$PSPDEV/bin:$PSPSDK/bin"

 ## Load the environment changes.
 source ~/.bashrc

 ## Build and install the toolchain + sdk.
 sudo ./toolchain-sudo.sh

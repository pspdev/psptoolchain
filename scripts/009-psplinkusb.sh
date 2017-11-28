#!/bin/bash
# psplinkusb.sh by Naomi Peori (naomi@peori.ca)

 ## Exit on errors
 set -e
 
 ## Download the source code if it does not already exist
 clone_git_repo github.com pspdev psplinkusb

 ## Enter the source directory
 cd psplinkusb

 ## Mac OS X fix
 if [ "$(uname)" == "Darwin" ]; then
   if [ -d /opt/local/include ] && [ -d /opt/local/lib ]; then # MacPorts
     export C_INCLUDE_PATH="/opt/local/include"
     export CPLUS_INCLUDE_PATH="/opt/local/include"
     export LIBRARY_PATH="/opt/local/lib"
   elif brew --version 1>/dev/null 2>&1; then # Homebrew
     HOMEBREW_PREFIX=$(brew --prefix)
     export C_INCLUDE_PATH="$HOMEBREW_PREFIX/include:$HOMEBREW_PREFIX/opt/readline/include"
     export CPLUS_INCLUDE_PATH="$C_INCLUDE_PATH"
     export LIBRARY_PATH="$HOMEBREW_PREFIX/lib:$HOMEBREW_PREFIX/opt/readline/lib"
   else
     # Additional package manager/well-known locations? Add them here...
     echo "WARNING: using libreadline from OS X, this may lead to compilation issues"
   fi
 fi

 ## Build and install.
 make -f Makefile.clients -j $(num_cpus) clean
 make -f Makefile.clients -j $(num_cpus)
 make -f Makefile.clients -j $(num_cpus) install
 make -f Makefile.clients -j $(num_cpus) clean

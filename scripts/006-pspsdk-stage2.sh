#!/bin/bash
# pspsdk-stage2.sh by Dan Peori (danpeori@oopo.net)

 ## Exit on errors
 set -e

 ## Download the source code if it does not already exist.
 clone_git_repo github.com pspdev pspsdk

 ## Enter the source directory.
 cd pspsdk

 ## Bootstrap the source.
 ./bootstrap

 ## Configure the build.
 CFLAGS="$CFLAGS -I/opt/local/include" CPPFLAGS="$CPPFLAGS -I/opt/local/include" LDFLAGS="$LDFLAGS -L/opt/local/lib" ./configure --with-pspdev="$PSPDEV"

 ## Build and install.
 make -j $(num_cpus) clean
 make -j $(num_cpus)
 make -j $(num_cpus) install
 make -j $(num_cpus) clean

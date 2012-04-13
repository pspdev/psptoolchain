#!/bin/sh
# psplibraries.sh by Takeshi Watanabe (takechi101010@gmail.com)

 ## clear CC and CXX
 unset CC
 unset CXX

 ## Exit on errors
 set -e

 ## Download the source code.
 ls psplibraries 1> /dev/null || git clone https://github.com/pspdev/psplibraries.git

 ## Enter the source directory.
 cd psplibraries
 git pull origin master

 ## Configure the build.
 ./libraries.sh

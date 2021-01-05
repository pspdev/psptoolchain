#!/bin/bash
# psplibraries.sh by Takeshi Watanabe (takechi101010@gmail.com)

 ## clear CC and CXX
 unset CC
 unset CXX

 ## Exit on errors
 set -e

 ## Download the source code.
    git clone https://github.com/pspdev/psplibraries --depth=1
 ## Enter the source directory.
 cd psplibraries

 ## Configure the build.
 ./libraries.sh

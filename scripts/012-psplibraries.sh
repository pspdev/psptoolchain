#!/bin/bash
# psplibraries.sh by Takeshi Watanabe (takechi101010@gmail.com)

 ## clear CC and CXX
 unset CC
 unset CXX

 ## Exit on errors
 set -e

 ## Download the source code.
 clone_git_repo github.com pspdev psplibraries

 ## Enter the source directory.
 cd psplibraries

 ## Configure the build.
 ./libraries.sh

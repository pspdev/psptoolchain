#!/bin/sh
# check-git.sh by Takeshi Watanabe (takechi101010@gmail.com)

 ## Check for git.
 git --version 1> /dev/null || { echo "ERROR: Install git before continuing."; exit 1; }

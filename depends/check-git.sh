#!/bin/sh
# check-git.sh by Takeshi Watanabe (takechi101010@gmail.com)

## Check for git.
git --version > /dev/null 2>&1 || { echo "ERROR: Install git before continuing."; exit 1; }


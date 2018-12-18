#!/bin/bash
# psplibraries.sh by Takeshi Watanabe (takechi101010@gmail.com)

. ../common.sh

# Exit on errors
set -e

# Download the source code.
clone_git_repo 'https://github.com/pspdev/psplibraries/' psplibraries

# Enter the source directory.
cd psplibraries

# Configure the build.
# Until psplibraries switches to any compliant shell we have to use bash.
/bin/bash ./libraries.sh

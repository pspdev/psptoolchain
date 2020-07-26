#!/bin/bash
# toolchain.sh by Naomi Peori (naomi@peori.ca)

 ## Load and export shared functions
 source common.sh
 export -f num_cpus
 export -f auto_extract
 export -f download_and_extract
 export -f clone_git_repo

 ## Enter the psptoolchain directory.
 cd "`dirname $0`" || { echo "ERROR: Could not enter the psptoolchain directory."; exit 1; }

 ## Create the build directory.
 mkdir -p build || { echo "ERROR: Could not create the build directory."; exit 1; }

 ## Enter the build directory.
 cd build || { echo "ERROR: Could not enter the build directory."; exit 1; }

 ## Fetch the depend scripts.
 DEPEND_SCRIPTS=(`ls ../depends/*.sh | sort`)

 ## Run all the depend scripts.
 for SCRIPT in ${DEPEND_SCRIPTS[@]}; do "$SCRIPT" || { echo "$SCRIPT: Failed."; exit 1; } done

 ## Fetch the build scripts.
 BUILD_SCRIPTS=(`ls ../scripts/*.sh | sort`)

# If specific steps were requested...
if [ $1 ]; then
  # Sort and run the requested build scripts.
  ARGS=(`printf "%.2d\n" $((10#$*)) | sort -n`)

  for ARG in ${ARGS[@]}; do
    found=0
    for SCRIPT in ${BUILD_SCRIPTS[@]}; do
      if [ `basename $SCRIPT | cut -c -2` -eq $ARG ]; then
        found=1
        "$SCRIPT" || { echo "$SCRIPT: Failed."; exit 1; }
      fi
    done
    [ $found -eq 1 ] || { echo "$ARG: Script not found."; exit 1; }
  done
else
  # Run all the existing build scripts.
  for SCRIPT in ${BUILD_SCRIPTS[@]}; do
    "$SCRIPT" || { echo "$SCRIPT: Failed."; exit 1; }
  done
fi

#!/bin/bash
# toolchain.sh by Naomi Peori (naomi@peori.ca)

 ## Load and export shared functions
 source common.sh
 export -f num_cpus
 export -f auto_extract
 export -f download_and_extract
 export -f clone_git_repo

 ## Enter the psptoolchain directory.
 cd "`dirname $0`" || { echo "ERROR: Could not enter the psptoolchain directory."; exit $(false); }

 ## Create the build directory.
 mkdir -p build || { echo "ERROR: Could not create the build directory."; exit $(false); }

 ## Enter the build directory.
 cd build || { echo "ERROR: Could not enter the build directory."; exit $(false); }

 ## Fetch the depend scripts.
 DEPEND_SCRIPTS=(`ls ../depends/*.sh | sort`)

 ## Run all the depend scripts.
 for SCRIPT in ${DEPEND_SCRIPTS[@]}; do "$SCRIPT" || { echo "$SCRIPT: Failed."; exit $(false); } done

 ## Fetch the build scripts.
 BUILD_SCRIPTS=(`ls ../scripts/*.sh | sort`)

 ## If specific steps were requested...
 if [ $1 ]; then

  ## Run the requested build scripts.
  for STEP in $@; do "${BUILD_SCRIPTS[$STEP-1]}" || { echo "${BUILD_SCRIPTS[$STEP-1]}: Failed."; exit $(false); } done

 else

  ## Run the all build scripts.
  for SCRIPT in ${BUILD_SCRIPTS[@]}; do "$SCRIPT" || { echo "$SCRIPT: Failed."; exit $(false); } done

 fi

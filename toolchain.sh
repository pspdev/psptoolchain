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

if [ $1 ]; then
  # Sort and run the requested build scripts.
  ARGS=(`printf "%.2d\n" $* | sort -n`)

  for (( i = 0; i < ${#ARGS[*]}; i++)); do
    found=false
    for (( j = 0; j < ${#BUILD_SCRIPTS[*]}; j++ )) ; do
	if [ `echo ${BUILD_SCRIPTS[j]} | grep -c ${ARGS[i]}` != 0  ]; then
		found=true
   		"${BUILD_SCRIPTS[j]}" || { echo "${BUILD_SCRIPTS[j]}: Failed."; exit 1; }
	else
		found=false
	fi
    done
    if [ !found ]; then
    	{ echo "ERROR: Script not found: ${ARGS[i]}";exit 1; }
    fi
  done
else
  # Run all the existing build scripts.
  for SCRIPT in ${BUILD_SCRIPTS[@]}; do
    "$SCRIPT" || { echo "$SCRIPT: Failed."; exit 1; }
  done
fi

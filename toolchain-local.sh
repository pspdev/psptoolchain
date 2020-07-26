export PSPDEV=$(pwd)/pspdev
export PATH=$PATH:$PSPDEV/bin

./pspdev.sh $@ || { echo "ERROR: Could not run the psptoolchain script."; exit 1; }

export PSPDEV=$(pwd)/pspdev
export PATH=$PATH:$PSPDEV/bin

## If specific steps were requested...
./toolchain.sh $@ || { echo "ERROR: Could not run the toolchain script."; exit 1; }

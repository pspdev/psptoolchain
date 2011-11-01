export PSPDEV=$(pwd)/pspdev
export PATH=$PATH:$PSPDEV/bin

./toolchain.sh $(seq 1 10)

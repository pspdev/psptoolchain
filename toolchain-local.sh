PSPDEV=$(pwd)/pspdev
PATH=$PATH:$PSPDEV/bin

./toolchain.sh $(seq 1 10)

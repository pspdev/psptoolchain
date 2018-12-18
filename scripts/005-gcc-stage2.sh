#!/bin/bash

. ../common.sh

EXTRA_LANGUAGES=',c++,objc,obj-c++'
EXTRA_CONFIGURE_FLAGS='--enable-cxx-flags=-G0'
CFLAGS_FOR_TARGET='-G0'
export CFLAGS_FOR_TARGET

source ../gcc.sh

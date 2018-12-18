#!/bin/bash

. ../common.sh

EXTRA_LANGUAGES=''
EXTRA_CONFIGURE_FLAGS='--without-headers --disable-libssp'
VARIANT_SUFFIX='-bootstrap'

source ../gcc.sh

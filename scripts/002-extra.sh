#!/bin/bash
# extra.sh by Francisco Javier Trujillo Mata (fjtrujy@gmail.com)

## Download the source code.
REPO_URL="https://github.com/pspdev/psptoolchain-extra"
REPO_FOLDER="psptoolchain-extra"

# Checking if a specific TAG has been selected, it is passed using parameter $1
[  -z "$1" ] && REPO_REFERENCE="main" || REPO_REFERENCE=$1
echo "Using repo reference $REPO_REFERENCE"

if test ! -d "$REPO_FOLDER"; then
  git clone $REPO_URL -b "${REPO_REFERENCE}" || exit 1
fi
cd "$REPO_FOLDER" && git fetch origin && git reset --hard "origin/${REPO_REFERENCE}" && git checkout "${REPO_REFERENCE}" || exit 1

## Build and install.
./build-all.sh || { exit 1; }
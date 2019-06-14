#!/bin/bash

set -x
source `dirname "$0"`/util.sh

waitForAptDpkgLocks

echo "Installing libindy dependencies"
apt-get install -y \
   build-essential \
   pkg-config \
   cmake \
   libssl-dev \
   libsqlite3-dev \
   libzmq3-dev \
   libncursesw5-dev


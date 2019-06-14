#!/bin/bash

INDY_SDK_PATH="$1"

set -ex

cd "$INDY_SDK_PATH/libindy"

echo "Bulding indy-sdk with debug"
cargo build
echo "libindy should be built at $INDY_SDK_PATH/libindy/target/debug/libindy.so"

echo "Bulding indy-sdk as release"
cargo build --release
echo "libindy should be built at $INDY_SDK_PATH/libindy/target/release/libindy.so"



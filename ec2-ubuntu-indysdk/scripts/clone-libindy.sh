#!/bin/bash

set -x

CLONE_TARGET="$1"

echo "Cloning indy-sdk into $CLONE_TARGET"
git clone "https://github.com/hyperledger/indy-sdk.git" "$CLONE_TARGET"
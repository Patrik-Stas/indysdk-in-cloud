#!/usr/bin/env bash

REPO_PATH="$1"
GIT_TAG="$2"

set -x

cd "$REPO_PATH";
git checkout "tags/$GIT_TAG"

if [ $? -ne 0 ]; then
    echo "Could not checkout indy-sdk on tag 'tags/$GIT_TAG'";
    exit 1;
fi;
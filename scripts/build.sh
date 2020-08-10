#!/usr/bin/env bash

set -e

OPENCUE_REPO=https://github.com/AcademySoftwareFoundation/OpenCue.git
BUILD_DIR=opencue-repo

# The Hugo theme (Docsy) is configured as a submodule.
# Recursively update and initilaize all Git submodules.
git submodule update --init --recursive

if [[ ! -d ${BUILD_DIR} ]]; then
  mkdir ${BUILD_DIR}
  git clone $OPENCUE_REPO ${BUILD_DIR}
fi

# Build the site
hugo

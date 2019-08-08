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

if [[ -f ${BUILD_DIR}/CONTRIBUTING.md ]]; then

  sed '/<!---/q' content/contributing/opencue/contributing.md \
    > contributing.tmp

  cd ${BUILD_DIR}

  # Determine when the file in the repo was last updated
  LAST_UPDATE=$(git log -n 1 --date=short CONTRIBUTING.md | grep "^Date:" | awk -F " " '{print $2}')

  cd ..

  # Update the publication date for the page
  sed -i '' '4s/20[0-9]\{2\}-[0-9]\{1,2\}-[0-9]\{1,2\}/'${LAST_UPDATE}'/' contributing.tmp

  tail -n +2 ${BUILD_DIR}/CONTRIBUTING.md >> contributing.tmp

  mv contributing.tmp content/contributing/opencue/contributing.md
fi

# Build the site
hugo

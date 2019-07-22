#!/usr/bin/env bash

set -e

# The Hugo theme (Docsy) is configured as a submodule.
# Recursively update and initilaize all Git submodules.
git submodule update --init --recursive

# Build the site
hugo

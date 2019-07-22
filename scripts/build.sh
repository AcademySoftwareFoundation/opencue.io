#!/usr/bin/env bash

set -e

# Fetch the currently configured version of the Hugo theme (Docsy)
git submodule update --init --recursive

# Build the site
hugo

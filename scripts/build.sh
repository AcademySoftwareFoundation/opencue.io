#!/usr/bin/env bash
set -e

# Fetch the currently configured version of the Hugo theme (Docsy)
git submodule update --init --recursive

# Create a temporary file with a copy of all of the contents up to
# the match string
sed -e '/<!---/q' content/en/contributing/contribute-to-documentation.md \
	> content/en/contributing/contribute-to-documentation.tmp

# Append a copy of everything from the second file a match string
# after to the temporary file
sed -n -e '/<!---/,$p' README.md \
	>> content/en/contributing/contribute-to-documentation.tmp

# Replace the original markdown file with the temporary copy
mv content/en/contributing/contribute-to-documentation.tmp \
	content/en/contributing/contribute-to-documentation.md

hugo

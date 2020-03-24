#!/usr/bin/env bash

# Get path to this script
DIR="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# Go to root of project
cd $DIR'/..'

# Build the docs
cd docs/

# Make the full docs
make docs

# Remove the old docs and copy the output to the final commit location
rm -rf ../html
cp -r build/html/ ../html
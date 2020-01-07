#!/usr/bin/env bash

# Get path to this script
DIR="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# Go to root of project
cd $DIR'/..'

# Build python environment in env/
python3 -m venv env

# Activate environment
source env/bin/activate

# Install pip and upgrade
pip install --upgrade pip

# Install all required packages
# File is created by: pip freeze > requirements.txt 
pip install -r requirements.txt

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

# Get a copy of the latest nasa-latex-docs
rm -rf env/nasa-latex-docs
git clone https://github.com/nasa/nasa-latex-docs.git env/nasa-latex-docs

# Create an alias for buildPDF.py
export NASA_LATEX_DOCS_ROOT="$DIR/../env/nasa-latex-docs/"
alias buildPDF.py='$DIR/../env/nasa-latex-docs/buildPDF.py'
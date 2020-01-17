#!/usr/bin/env bash

echo "Build sample report: $1"

cp -r source/templates/report/ tmp/report-$1/

sed -i ".bak" "s/documentclass\[\]/documentclass\[template=$1\]/g" tmp/report-$1/report.tex

${NASA_LATEX_DOCS_ROOT}/buildPDF.py tmp/report-$1/report.tex --output ${PWD}/source/static/reports/report-$1.pdf --quiet
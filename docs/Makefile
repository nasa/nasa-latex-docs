# Minimal makefile for Sphinx documentation
#

# You can set these variables from the command line, and also
# from the environment for the first two.
SPHINXOPTS    ?=
SPHINXBUILD   ?= sphinx-build
SOURCEDIR     = source
BUILDDIR      = build

# Put it first so that "make" without argument is like "make help".
help:
	@$(SPHINXBUILD) -M help "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)

.PHONY: help Makefile

reports:
	@#
	###########################################
	# Prepare Sample Reports
	###########################################
	@rm -rf tmp
	@mkdir tmp

	@# Use latest version of nasa-latex-docs to get current support folder
	@${NASA_LATEX_DOCS_ROOT}/buildPDF.py --new tmp/test-report --quiet
	@rm -rf source/templates/report/support/
	@cp -r tmp/test-report/support source/templates/report/

	@# Logic to loop through each template in parallel
	@printf '%s\0' tech-memo tech-report | xargs -P 10 -0 -I _ ../bin/build-template.sh _ 


snippets:
	@#
	###########################################
	# Prepare Snippets
	###########################################

	@# Loop through .tex snippets and create PNG files - use xargs to do this in parallel
	@find source/static/snippets/*.tex -maxdepth 1 -type f | xargs -I{} -P 10 ${NASA_LATEX_DOCS_ROOT}/buildPDF.py {} --standalone-png

	@# Loop through PNG files and scale down in size for HTML docs
	@find source/static/snippets/*.png -maxdepth 1 -type f -exec convert -scale 50% {} {} \;

docs:
	@# Remove old artifacts
	@rm -rf build

	@# Prepare the pre-built LaTeX content
	@make reports
	@make snippets

	###########################################
	# Build Sphinx Docs
	###########################################
	@make html

# Catch-all target: route all unknown targets to Sphinx using the new
# "make mode" option.  $(O) is meant as a shortcut for $(SPHINXOPTS).
%: Makefile
	@$(SPHINXBUILD) -M $@ "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)

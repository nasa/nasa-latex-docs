# Minimal makefile for Sphinx documentation
#

# You can set these variables from the command line, and also
# from the environment for the first two.
SPHINXOPTS    ?=
SPHINXBUILD   ?= sphinx-build
SOURCEDIR     = source
BUILDDIR      = build

define make_report
    @echo 'Build sample report: $(1)'
    @cp -r source/templates/report/ tmp/report-$(1)/
    @sed -i ".bak" "s/documentclass\[\]/documentclass\[template=$(1)\]/g" tmp/report-$(1)/report.tex
    @${NASA_LATEX_DOCS_ROOT}/buildPDF.py tmp/report-$(1)/report.tex --output ${PWD}/source/static/report-$(1).pdf
endef

# Put it first so that "make" without argument is like "make help".
help:
	@$(SPHINXBUILD) -M help "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)

.PHONY: help Makefile

docs:
	@#
	###########################################
	# Prepare Sample Reports
	###########################################

	@# Remove old artifacts
	@rm -rf build
	@rm -rf tmp
	@mkdir tmp

	@# Use latest version of nasa-latex-docs to get current support folder
	@${NASA_LATEX_DOCS_ROOT}/buildPDF.py --new tmp/test-report
	@rm -rf source/templates/report/support/
	@cp -r tmp/test-report/support source/templates/report/

# 	@$(call make_report,tech-memo)
# 	@$(call make_report,tech-report)

	###########################################
	# Build Sphinx Docs
	###########################################
	@make html

# Catch-all target: route all unknown targets to Sphinx using the new
# "make mode" option.  $(O) is meant as a shortcut for $(SPHINXOPTS).
%: Makefile
	@$(SPHINXBUILD) -M $@ "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)

# Minimal makefile for Sphinx documentation
#

# You can set these variables from the command line.
SPHINXOPTS    	=
SPHINXBUILD   	= sphinx-build
SPHINXPROJ    	= NASA-LaTeX-Docs
SOURCEDIR     	= source
BUILDDIR      	= build

LATEXPATH 		= source/latex
FIGPATH 			= source/latex/figs

# Put it first so that "make" without argument is like "make help".
help:
	@$(SPHINXBUILD) -M help "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)

.PHONY: help Makefile

full:
	# Remove the old build and doctrees
	@rm -rf build/doctrees/
	@rm -rf build/html/
	@rm -rf $(LATEXPATH)/XYZ_Conference_Paper_2017
	# Build a sample document structure
	@nasa-latex-docs/buildPDF.py XYZ_Conference_Paper.tex -s $(LATEXPATH)/XYZ_Conference_Paper_2017

	# Build the new document with all the examples
	@nasa-latex-docs/buildPDF.py $(LATEXPATH)/samples.tex -f
	@convert -trim -density 100 $(LATEXPATH)/samples.pdf -quality 100 $(FIGPATH)/samples.png
	# Rename all the files
	@mv $(FIGPATH)/samples-0.png $(FIGPATH)/figure.png
	@mv $(FIGPATH)/samples-1.png $(FIGPATH)/two_figure.png
	@mv $(FIGPATH)/samples-2.png $(FIGPATH)/two_figure_alt.png
	@mv $(FIGPATH)/samples-3.png $(FIGPATH)/subfigure.png
	@mv $(FIGPATH)/samples-4.png $(FIGPATH)/table.png
	@mv $(FIGPATH)/samples-5.png $(FIGPATH)/table_column.png
	@mv $(FIGPATH)/samples-6.png $(FIGPATH)/table_row.png
	@mv $(FIGPATH)/samples-7.png $(FIGPATH)/doc_tree_quick.png
	@mv $(FIGPATH)/samples-8.png $(FIGPATH)/doc_visibility.png
	@make html 


# Catch-all target: route all unknown targets to Sphinx using the new
# "make mode" option.  $(O) is meant as a shortcut for $(SPHINXOPTS).
%: Makefile
	@$(SPHINXBUILD) -M $@ "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)
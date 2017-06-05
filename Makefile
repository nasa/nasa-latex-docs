# Minimal makefile for Sphinx documentation
#

# You can set these variables from the command line.
SPHINXOPTS    	=
SPHINXBUILD   	= sphinx-build
SPHINXPROJ    	= NASA-LaTeX-Docs
SOURCEDIR     	= source
BUILDDIR      	= build

LATEXPATH 		= source/examples/latex
FIGPATH 			= source/examples/latex/figs

# Define a custom convert command for all images
convert_cmd 	:= convert -define pdf:use-cropbox=true -density 150 -scale 80% -trim

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

	# Convert and rename all the files
	@$(convert_cmd) $(LATEXPATH)/samples.pdf[0] 	$(FIGPATH)/figure.png
	@$(convert_cmd) $(LATEXPATH)/samples.pdf[1] 	$(FIGPATH)/two_figure.png
	@$(convert_cmd) $(LATEXPATH)/samples.pdf[2] 	$(FIGPATH)/two_figure_alt.png
	@$(convert_cmd) $(LATEXPATH)/samples.pdf[3] 	$(FIGPATH)/subfigure.png
	@$(convert_cmd) $(LATEXPATH)/samples.pdf[4] 	$(FIGPATH)/table.png
	@$(convert_cmd) $(LATEXPATH)/samples.pdf[5] 	$(FIGPATH)/table_column.png
	@$(convert_cmd) $(LATEXPATH)/samples.pdf[6] 	$(FIGPATH)/table_row.png
	@$(convert_cmd) $(LATEXPATH)/samples.pdf[7] 	$(FIGPATH)/doc_tree_quick.png
	@$(convert_cmd) $(LATEXPATH)/samples.pdf[8] 	$(FIGPATH)/doc_visibility.png
	@$(convert_cmd) $(LATEXPATH)/samples.pdf[9] 	$(FIGPATH)/equation_1.png
	@$(convert_cmd) $(LATEXPATH)/samples.pdf[10] $(FIGPATH)/equation_2.png
	@$(convert_cmd) $(LATEXPATH)/samples.pdf[11] $(FIGPATH)/equation_matrix.png
	@$(convert_cmd) $(LATEXPATH)/samples.pdf[12] $(FIGPATH)/equation_bmatrix.png
	@$(convert_cmd) $(LATEXPATH)/samples.pdf[13] $(FIGPATH)/equation_bmatrix2.png
	@$(convert_cmd) $(LATEXPATH)/samples.pdf[14] $(FIGPATH)/equation_pmatrix.png
	@$(convert_cmd) $(LATEXPATH)/samples.pdf[15] $(FIGPATH)/equation_vmatrix.png
	@$(convert_cmd) $(LATEXPATH)/samples.pdf[16] $(FIGPATH)/equation_vmatrix2.png
	@$(convert_cmd) $(LATEXPATH)/samples.pdf[17] $(FIGPATH)/equation_smallmatrix.png
	@$(convert_cmd) $(LATEXPATH)/samples.pdf[18] $(FIGPATH)/equation_split.png
	@$(convert_cmd) $(LATEXPATH)/samples.pdf[19] $(FIGPATH)/tikz_block.png

	# Call the make html command to publish the latest results
	@make html 

# Catch-all target: route all unknown targets to Sphinx using the new
# "make mode" option.  $(O) is meant as a shortcut for $(SPHINXOPTS).
%: Makefile
	@$(SPHINXBUILD) -M $@ "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)
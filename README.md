NASA-LaTeX-Docs
================

Please refer to the official guide: [NASA-LaTeX-Docs Guide](https://nasa.github.io/nasa-latex-docs/build/html)

Usage:
-------

With this LaTeX package, the formatting is all handled internally so that report developers only need to create their own content following a provided template (or even create their own). If not using a template (example: AIAA or IEEE submission), this package also comes with an incredibly versatile, OS independent, Python build script and Latexmk configuration file for easy document type-setting and warning/error detection. 

The build script is located in the following directory and can be used to build **any LaTeX document**:

    nasa-latex-docs/buildPDF.py

It may be invoked through the command line as follows:

    python /path/to/buildPDF.py texfile [OPTIONS]

System Requirements:
-------

- TeX Live Distribution 2015+ (with latest updates)
- Python 2.6+, Python 3+

License
-------

Software release at NASA is governed by NPR 2210.1C. NPR 2210.1C establishes the roles, responsibilities, and procedures for reporting, reviewing, and releasing software under various conditions, including open source. Every center has a Software Release Authority (SRA). The SRA processes requests for software release and coordinates legal, export control, IT security, 508 compliance, and software engineering standards compliance reviews. Projects hoping to release software should contact their SRA early to discuss their goals and begin the reporting, review, and release process.

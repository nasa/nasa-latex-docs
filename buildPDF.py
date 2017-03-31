#!/usr/bin/env python

###################################################
# Import relevant modules
###################################################

import os
import re
import sys
import time
import shutil
import inspect
import argparse
import mimetypes
import fnmatch
from tempfile import mkstemp
from subprocess import Popen, PIPE

###################################################################
# Define class to house terminal text options (tc)
###################################################################

class tc:
   PINK        = '\033[95m'
   BLUE        = '\033[94m'
   GREEN       = '\033[92m'
   YELLOW      = '\033[93m'
   RED         = '\033[91m'
   ENDC        = '\033[0m'
   BOLD        = '\033[1m'
   UNDERLINE   = '\033[4m'

###################################################################
# Create methods for printing errors, warnings, and status
###################################################################

def print_error(message, pre='', exit=True):
   print pre + tc.BOLD + tc.RED + "\nERROR: " + tc.ENDC + message + tc.ENDC
   if exit:
      print tc.BOLD+"\nExiting buildPDF.py ..."+tc.ENDC
      sys.exit(1)

def print_status(title, message, pre=''):
   print pre + tc.BOLD + title + tc.ENDC + ' : ' + message

def print_warn(message, pre=''):
   print pre + tc.BOLD + tc.BLUE + "WARNING: " + tc.ENDC + message + tc.ENDC

def delete_file(file_abs_path):
   if os.path.isfile(file_abs_path):
      os.remove(file_abs_path)

def replace_file_line(file_path, pattern, subst):
   # Create temp file
   fh, abs_path = mkstemp()
   with open(abs_path,'w') as new_file:
      with open(file_path) as old_file:
         for line in old_file:
            new_file.write(line.replace(pattern, subst))
   os.close(fh)
   # Remove original file
   os. remove(file_path)
   # Move new file
   shutil.move(abs_path, file_path)

###################################################################
# Define the main buildPDF class
###################################################################

class buildPDF():

   def __init__(self):

      # Define version of script and NASA-LaTeX-Docs
      self.version = 'March 30, 2017 - v1.0'

      # Get the current environment variables to pass to subprocess
      self.ENV = os.environ.copy()

      # Define some paths based on the location of this file
      self.buildPDF_abs_path          = os.path.abspath(os.path.abspath(inspect.getfile(inspect.currentframe())))
      self.buildPDF_dir_path          = os.path.dirname(self.buildPDF_abs_path)

      ###################################################################
      # Create the argument parser and parse arguments
      ###################################################################

      # Setup the argument parser class
      argParser = argparse.ArgumentParser(
         usage=tc.BLUE+"\n  python {0} texfile [OPTIONS]".format(self.buildPDF_abs_path)+tc.ENDC,
         description=tc.BOLD+"Description: "+tc.ENDC+ 
         """
  Python script to efficiently build LaTeX file and create PDF  
  Developed to be used in conjunction with NASA-LaTeX-Docs, but
  may be used to build """ +tc.BOLD+"any TeX document"+tc.ENDC+ """ 
  - - - - - - - - -
  GitHub Repository: https://github.com/nasa/nasa-latex-docs
  Comprehensive Doc: https://nasa.github.io/nasa-latex-docs """,
         epilog=tc.BOLD+"buildPDF.py Version Information: "+tc.ENDC+self.version,
         formatter_class=argparse.RawTextHelpFormatter, add_help=False)

      argParser._optionals.title = tc.BOLD+"Optional Arguments"+tc.ENDC
      argParser._positionals.title = tc.BOLD+"Required Arguments"+tc.ENDC

      # Define the input arguments (positional and optional)
      argParser.add_argument('texfile', type=str, nargs='?', 
         help="The name of the main level TeX file to build")
      argParser.add_argument("-h",  "--help", action="store_true", 
         help="Show this help message and exit\n ")
      argParser.add_argument("-v",  "--verbose", action="store_true", 
         help="Verbose option of build output to screen\n ")
      argParser.add_argument("-f",  "--force", action="store_true", 
         help="Force a new build even if no file changes detected\n ")
      argParser.add_argument("-w",  "--watch", action="store_true", 
         help="Enables continuous builds on any file changes\n ")
      argParser.add_argument("-c",  "--clean", action="store_true", 
         help="Removes the tmp/ directory after successful build\n ")
      argParser.add_argument("-e",  "--export", action="store_true", 
         help="Creates a standalone version of the document with \nminimum required dependencies and input files\n ")
      argParser.add_argument("-l",  "--latexpath", type=str, metavar=tc.BLUE+'LATEX_PATH'+tc.ENDC, 
         help="LaTeX installation on computer to add to PATH environment\nExample: Mac location = /Library/TeX/texbin,\notherwise will use the current PATH environment\n ")
      argParser.add_argument("-t",  "--texinputs", type=str, metavar=tc.BLUE+'TEXINPUTS_PATH'+tc.ENDC, 
         help="User defined directory path to append to TEXINPUTS environment\nTEXINPUTS controls where LaTeX searches for input files\n ")
      argParser.add_argument("-o",  "--output", type=str, metavar=tc.BLUE+'OUTPUT_PDF_NAME'+tc.ENDC, 
         help="Rename the output pdf with a user specified name/location,\notherwise will build texfile.tex to texfile.pdf\n ")
      argParser.add_argument("-p",  "--preview", action='store', nargs='?', default=False, metavar=tc.BLUE+'PROGRAM_NAME'+tc.ENDC, 
         help="Option to open pdf viewer program after build\nDefault: Mac=Preview, Linux=Evince, Windows=gsview32\n ")
      argParser.add_argument("-s",  "--structure", action="store", nargs='?', default=False, metavar=tc.BLUE+'FOLDER_NAME'+tc.ENDC, 
         help="Creates document structure, with minimum .tex and .bib files\nDefault: If no name provided, will create in 'TexDocument/'")

      # Hidden options that are used for interim latexmk builds
      argParser.add_argument("--latexmk-passthrough-build", nargs='?', help=argparse.SUPPRESS)
      argParser.add_argument("--latexmk-passthrough-success", action="store_true", help=argparse.SUPPRESS)
      argParser.add_argument("--latexmk-passthrough-fail", action="store_true", help=argparse.SUPPRESS)

      # Parse the user arguments
      self.args = argParser.parse_args() 

      # Check if --help is true, display the help text and exit
      if self.args.help:
         argParser.print_help()
         sys.exit(0)

      ###################################################################
      # Error checking for input TeX file and --structure option
      ###################################################################

      if not self.args.texfile:
         if self.args.structure != False:
            print_error('Provide a save name for main TeX file in structure template, example:',exit=False)
            if self.args.structure == None:
               print tc.BOLD + "  python buildPDF.py texfile.tex -s" + tc.ENDC
            else:
               print tc.BOLD + "  python buildPDF.py texfile.tex -s {0}".format(self.args.structure) + tc.ENDC
            sys.exit(1)
         else:
            print_error('No buildable .tex file provided',exit=False)
            argParser.print_usage()
            sys.exit(1)

      ###################################################################
      # Determine if this is a pass-through build called by latexmk
      ###################################################################

      # Initialize return code from latexmk call to zero
      self.latexmk_returncode = 0 

      if self.args.latexmk_passthrough_build or self.args.latexmk_passthrough_success or self.args.latexmk_passthrough_fail:
         self.latexmk_passthrough = True
      else:
         self.latexmk_passthrough = False      

      ###################################################################
      # Initialize class parameters utilized by various methods
      ###################################################################

      self.TeX_Root           = ''
      self.input_abs_path     = ''
      self.input_dir_path     = ''
      self.input_bare         = ''
      self.input_tex          = ''
      self.output_abs_path    = ''
      self.output_dir_path    = ''
      self.output_bare        = ''
      self.output_pdf         = ''

   ###################################################################
   # METHOD: determine the installed TeX version 
   ###################################################################

   def _get_tex_ver(self):

      # Update the path information if --latexpath provided
      if self.args.latexpath:
         latexpath_abs_path = os.path.abspath(self.args.latexpath)
         if not os.path.isdir(latexpath_abs_path):
            print_warn("User defined LATEX_PATH entry does not exist: '{0}'".format(latexpath_abs_path))
         else:
            self.ENV['PATH'] = self.args.latexpath + os.pathsep + self.ENV['PATH']

      # Attempt to get the TeX version with command line call   
      get_tex = Popen(['tex --version'], env=self.ENV, shell=True, stdout=PIPE, stderr=PIPE)
      get_tex.wait()
      
      # Check the return status of the TeX version call
      if get_tex.returncode > 0:
         print_error('No TeX distribution installation found, check PATH environment')
      else:
         self.ENV['TEX_VERSION']  = get_tex.stdout.read().splitlines()[0].strip()

      # Make sure the TeX distribution installed is at least from 2015+
      if any(x in self.ENV['TEX_VERSION'] for x in ['2015','2016','2017','2018','2019','2020']):    
         if not self.latexmk_passthrough:
            print_status("buildPDF.py file Version    ",self.version) 
            print_status("TeX Distribution Version",self.ENV['TEX_VERSION'])  
      else:
         print_error('Outdated TeX Distribution: {0}\n  NASA-LaTeX-Docs requires TeX distribution versions of 2015+'.format(self.ENV['TEX_VERSION']))

      return

   ###################################################################
   # METHOD: get all the various file forms for input tex and output pdf
   ###################################################################

   def _get_file_forms(self, texfile2build):
      
      # Strip the texfile argument of any extension, then ensure .tex is added
      texfile_input_bare   = texfile2build.rsplit('.', 1)[0]
      texfile_input_tex    = texfile_input_bare + '.tex'

      # Define the relevant input file paths based on texfile argument
      self.input_abs_path     = os.path.abspath(texfile_input_tex)
      self.input_dir_path     = os.path.dirname(self.input_abs_path )
      self.input_bare         = os.path.basename(texfile_input_bare)
      self.input_tex          = os.path.basename(texfile_input_tex)

      # Make sure the input TeX file exits
      if not os.path.isfile(self.input_abs_path) and self.args.structure == False:
         print_error("Input TeX file was not found: '{0}'".format(self.input_abs_path))

      # Define the output file format names    
      if self.args.output:
         # Get the filename parts from the user input
         output_path, output_filename = os.path.split(self.args.output) 
         self.output_bare        = os.path.basename(output_filename.rsplit('.', 1)[0])
         self.output_pdf         = self.output_bare + '.pdf'
         
         # If no output path found, build pdf in directory of texfile input
         if not output_path:
            self.output_abs_path    = os.path.join(self.input_dir_path,self.output_pdf)
         else:
            self.output_abs_path    = os.path.join(output_path,self.output_pdf)
         self.output_dir_path    = os.path.dirname(self.output_abs_path)           
      else:
         # If no user input provided, build pdf using texfile input name/location
         self.output_bare        = self.input_bare 
         self.output_pdf         = self.input_bare + '.pdf'
         self.output_abs_path    = os.path.join(self.input_dir_path,self.output_pdf)
         self.output_dir_path    = os.path.dirname(self.output_abs_path )

      # Prior to exit, set TeX_Root to be same as texfile2build method input
      self.TeX_Root =  self.input_abs_path  
      return

   ###################################################################
   # METHOD: Creates a boilerplate document template
   ###################################################################

   def _create_doc_structure(self):

      # If structure option not given, exit
      if self.args.structure == False:
         return

      # Get the folder name by the user, else default to 'TexDocument'  
      if self.args.structure == None:
         structure_dir = self.input_bare
      else: 
         structure_dir = self.args.structure

      # Determine the path where document structure will be created   
      structure_path = os.path.abspath(structure_dir)

      # Make sure that the defined structure_path does not already exist
      if os.path.isdir(structure_path):
         print_error(tc.BOLD + structure_path + tc.ENDC + ": directory already exists!")
      else:
         if self.args.structure == None:
            print_warn("No folder name provided, will create new directory structure in:\n  {0}".format(tc.BOLD+structure_path+tc.ENDC), pre='\n') 
            response = raw_input("\nAre you sure you want to create new document folder here?\n  Please respond y/n: ")       
            if response.lower() == 'no' or response.lower() == 'n':
               print tc.BOLD+"\nExiting buildPDF.py ..."+tc.ENDC 
               sys.exit(1)
            elif response.lower() == 'yes' or response.lower() == 'y':
               pass
            else:
               print_error("User response, '{0}', not recognized".format(response))
      
      # Copy the entire template directory
      shutil.copytree(os.path.join(self.buildPDF_dir_path ,'support','boilderplate'), structure_path)

      # Rename the files with the given user input name
      try: 
         os.rename(os.path.join(structure_path,'main.tex'), os.path.join(structure_path,self.input_tex))
         os.rename(os.path.join(structure_path,'bib','main.bib'), os.path.join(structure_path,'bib',self.input_bare+'.bib'))
         replace_file_line(os.path.join(structure_path,self.input_tex),r'\addbibresource{}',r'\addbibresource{{{0}}}'.format(self.input_bare+'.bib'))
      except: 
         shutil.rmtree(structure_path)
         print_error("Invalid input file name: '{0}'".format(self.input_tex))
      
      # Print path to created template and exit
      print "Template created in:\n  '{0}'\n\nTo build PDF run:\n  python {2} {1}".format(tc.BOLD+structure_path+tc.ENDC,tc.BOLD+os.path.join(structure_path,self.input_tex)+tc.ENDC,self.buildPDF_abs_path)
      sys.exit(0) 

      return

   ###################################################################
   # METHOD: determines if there is user comment at top of file for "TEX Root"
   ###################################################################

   def _get_tex_root(self):

      # Go to directory where input TeX file is located
      os.chdir(self.input_dir_path)

      # Determine if TeX root is defined by user comment
      with open(self.input_abs_path, 'r') as f:
         first_line = f.readline().strip()
         
      # Now check to see if user provided a TeX root commetn
      if 'TEX Root ='.lower() in first_line.lower():
         self.TeX_Root = first_line.rsplit('=', 1)[1].strip()
         if not os.path.isfile(self.TeX_Root):
            print_error("TeX Root file not found: '{0}'\nSearch Path: {1}".format(first_line,os.path.join(self.input_dir_path,self.TeX_Root)))

      return

   ###################################################################
   # METHOD: method to recursively add directory tree to path
   ###################################################################

   def _add_path_recursive(self, dir_path_list, tex_env_var):

      tex_search_dirs = []

      # Get directory of this script and find all sub-directories
      for search_path in dir_path_list:
         for root, dirs, files in os.walk(search_path):
            dirs[:] = [d for d in dirs if not d.startswith('.')]
            for dir in dirs:
               # Don't include tmp/ or _standalone/ on any path
               if (self.ENV['TMPDIR'] in os.path.join(root, dir)) or ('_standalone' in os.path.join(root, dir) and '_standalone' not in self.input_dir_path):
                  continue
               else:
                  tex_search_dirs.append(os.path.join(root, dir))

      # Make sure the first entry is the location of document base
      tex_search_dirs.insert(0, self.input_dir_path)

      # Add search paths to various TeX recognized environment variables         
      if tex_env_var not in self.ENV:
         self.ENV[tex_env_var] = os.pathsep.join(tex_search_dirs) + os.pathsep
      else:
         self.ENV[tex_env_var] += os.pathsep + os.pathsep.join(tex_search_dirs) + os.pathsep  

   ###################################################################
   # METHOD: sets all the appropriate environment variables and paths
   ###################################################################

   def _set_environment(self):

      # Define the tmp/ directory where all build output files will be piped to
      self.ENV['TEXMFOUTPUT']         = os.path.join(self.input_dir_path,'tmp')
      self.ENV['TMPDIR']              = os.path.join(self.input_dir_path,'tmp')

      self._add_path_recursive([self.input_dir_path,self.buildPDF_dir_path], 'TEXINPUTS')
      self._add_path_recursive([self.input_dir_path,self.buildPDF_dir_path], 'TEXMFHOME')
      self._add_path_recursive([self.input_dir_path,self.buildPDF_dir_path], 'BIBINPUTS') 

      # Environment variable to pass to "latexmkrc" config file
      self.ENV['INPUT_SOURCE_PATH']   = self.input_abs_path
      self.ENV['OUTPUT_PDF_NAME']     = self.output_abs_path
      self.ENV['BUILDPDF_PATH']       = self.buildPDF_abs_path

      # --verbose user option disables the default silent flag to latexmk
      if self.args.verbose:
         self.ENV['SILENT'] = '0'
      
      # If --preview is not False (i.e. None or True) enable preview options
      if self.args.preview != False:
         self.ENV['PREVIEW_PDF'] = '1'
         if self.args.preview:
            self.ENV['PREVIEW_PROGRAM'] = self.args.preview
      
      # If --watch is true then enable the CONTINUOUS_PREVIEW parameter for latexmk
      if self.args.watch:
         self.ENV['CONTINUOUS_PREVIEW'] = '1'    

      # Check if --texinputs option provided, validate and add to path if it exists    
      if self.args.texinputs:
         texinputs_abs_path = os.path.abspath(self.args.texinputs)
         if not os.path.isdir(texinputs_abs_path):
            print_warn("User defined TEXINPUTS entry does not exist: '{0}'".format(texinputs_abs_path))
         else:
            self.ENV['TEXINPUTS'] += os.pathsep + texinputs_abs_path + os.pathsep
            self._add_path_recursive([texinputs_abs_path], 'TEXINPUTS')

      return

   ###################################################################
   # METHOD: runs the wrapper latexmk call 
   ###################################################################

   def _run_latexmk(self):

      # Do not call latexmk if this is a pass-through build
      if self.latexmk_passthrough:
         # Determine if interim build has failed from --latexmk-passthrough-fail
         if self.args.latexmk_passthrough_fail:
            self.latexmk_returncode = 1
         return
  
      # Make sure that the latexmkrc file exists in the expected location
      self.latexmkrc_abs_path = os.path.join(self.buildPDF_dir_path,'support','latexmk','latexmkrc')
      if not os.path.isfile(self.latexmkrc_abs_path):
         matches = []
         for root, dirnames, filenames in os.walk(self.buildPDF_dir_path):
            for filename in fnmatch.filter(filenames, 'latexmkrc'):
               matches.append(os.path.join(root, filename))
         if len(matches) > 1:
            print_error('Multiple latexmkrc file matches found on path!\n {0}'.format(matches)) 
         elif len(matches) < 1:
            print_error('latexmkrc file not found anywhere on search path!\nExpected NASA-LaTeX-Docs location: nasa-latex-docs/support/latexmk/latexmkrc')                  
         else:
            self.latexmkrc_abs_path = matches[0]

      print_status("Building from TeX Root  ",self.input_abs_path) 

      # Go to directory where input TeX file is located
      os.chdir(self.input_dir_path)

      # Create the tmp/ dir if it does not exist
      if not os.path.exists(self.ENV['TMPDIR']):
         os.makedirs(self.ENV['TMPDIR'])

      # Find all folders in current input_dir_path that contain a .tex file (required for \include{} command)  
      dirs_with_tex = set(folder for folder, subfolders, files in os.walk(self.input_dir_path) for file_ in files if os.path.splitext(file_)[1] == '.tex')   
      
      # Create these directories in tmp/ so that correct .aux files can be written there
      for dir_with_tex in dirs_with_tex:
         dir_with_tex = dir_with_tex.replace(self.input_dir_path+os.sep,'').strip()      
         if dir_with_tex and not os.path.exists(os.path.join(self.ENV['TMPDIR'],dir_with_tex)):
            if self.input_bare+'_standalone' not in dir_with_tex:
               os.makedirs(os.path.join(self.ENV['TMPDIR'],dir_with_tex))

      # Add blank .bbl file 
      bbl_file = os.path.join(self.ENV['TMPDIR'],self.input_bare+'.bbl')  
      if not os.path.isfile(bbl_file):
         open(bbl_file, 'a').close()  

      try:

         if self.args.force:
            latexmk = Popen(['latexmk',self.input_bare,'-g','-r',self.latexmkrc_abs_path], env=self.ENV)
         else:
            latexmk = Popen(['latexmk',self.input_bare,'-r',self.latexmkrc_abs_path], env=self.ENV)
         latexmk.wait()

      except KeyboardInterrupt:
         latexmk.kill()
         print_warn("Keyboard Interrupt: Exiting continuous preview watch mode",pre='\n')

         # Delete the tmp/ directory if user specifies   
         if self.args.clean and latexmk.returncode == 0:
            shutil.rmtree(self.ENV['TMPDIR'])   

         sys.exit(latexmk.returncode)

      try:
         if latexmk.returncode == 0: 
            with open(os.path.join(self.ENV['TMPDIR'],'build.out'), 'r') as f:
               latexmk.returncode = int(f.readline().strip())
      except:
         pass

      self.latexmk_returncode = latexmk.returncode

      return

   ###################################################################
   # METHOD: runs the passthrough pdflatex build calls from latexmk
   ###################################################################

   def _run_pdflatex(self):

      # Only run this method when --latexmk-passthrough-build option is True
      if not self.args.latexmk_passthrough_build:
         return

      # Define file paths in tmp/ to place build log file
      pdflatex_out   = os.path.join(self.ENV['TMPDIR'],'pdflatex.out')
      texfot_out     = os.path.join(self.ENV['TMPDIR'],'texfot.out')
      build_status   = os.path.join(self.ENV['TMPDIR'],'build.out')

      # Run pdflatex command with all the appropriate options
      # Wrap call to pdflatex with texfot in order to generate texfot error/warning log file
      pdflatex = Popen("max_print_line=999  texfot --tee='{0}' pdflatex -synctex=1 -file-line-error --shell-escape {1} '{2}' > '{3}'".format(pdflatex_out,self.args.latexmk_passthrough_build,self.input_abs_path,texfot_out), env=self.ENV, shell=True, stdout=PIPE, stderr=PIPE)
      pdflatex.wait()

      # For persistence across interim builds, write the exit status to file
      f = open(build_status, 'w')
      f.write(str(pdflatex.returncode))
      f.close()

      # Exit with the return code from pdflatex
      sys.exit(pdflatex.returncode) 

      return

   ###################################################################
   # METHOD: prints log summary of errors and warnings
   ###################################################################

   def _print_texfot(self, buildFailFlag):

      # Define a list of strings to remove completely from line
      str_remove = [
      '(see the transcript file for additional information)',
      ]

      # Define a list of strings to delete if encountered in a line
      str_skip_line = [
      'This is pdfTeX',
      'Output written on',
      'Using fall-back',
      'Package layouts Warning',
      'Overwriting file',
      'Writing text',
      'Tab has been converted to Blank Space',
      ]

      # Strings to display was warnings
      str_warn = ['LaTeX Warning','Warning','pdfTeX warning','Underfull','Overfull']
      
      # Strings to display as errors
      str_error = ['Missing','Undefined control sequence','Error','LaTeX Error','Too many',"You can't"]

      if buildFailFlag:
         log_sum_str = tc.BOLD+tc.RED+"="*25+tc.ENDC+tc.BOLD+" Log Summary "+tc.ENDC+tc.RED+"="*25+tc.ENDC
      else:
         log_sum_str = tc.BOLD+"="*25+" Log Summary "+"="*25+tc.ENDC

      print '\n'+log_sum_str

      with open(os.path.join(self.ENV['TMPDIR'],'texfot.out')) as texfot:
         i = 0
         first_line = True
         something_to_print = False
         for line in texfot:

            # Specific sting replacements:
            # Replace absolute path for input with just the filename
            line = line.replace(self.input_abs_path,self.input_tex)
            # This error would occur if absolutely no text was provided in between begin/end document
            line = line.replace('No pages of output','Error: No text content found between \\begin{document} and \\end{document}')

            if first_line:
               first_line = False
               continue
            if any(word in line for word in str_skip_line):  
               continue

            for word in str_remove:
               line = line.replace(word,'')

            for word in str_warn:
               line = line.replace(word,tc.BOLD+word+tc.ENDC)

            for word in str_error:
               line = line.replace(word,tc.BOLD+tc.RED+word+tc.ENDC)

            if line.strip():
               something_to_print = True
               print line.strip()

      if not something_to_print:
         print "  No warnings or errors to report"
      
      if buildFailFlag:
         print log_sum_str + '\n'
      else:
         print log_sum_str
      return

   ###################################################################
   # METHOD: runs the passthrough pdflatex build calls from latexmk
   ###################################################################

   def _run_arlatex(self, support_path):

      # Go to directory where input TeX file is located
      os.chdir(support_path)

      support_file_list = os.listdir(support_path)

      # Check to see if using nasa-latex-docs.cls file
      if 'nasa-latex-docs.cls' not in support_file_list:
         return
      else:
         support_file_list.remove('nasa-latex-docs.cls')    

      # Build up the arlatex string command
      arlatex_exec_string = 'arlatex --document=nasa-latex-docs.cls'   
      support_file_keep = []
      for support_file in support_file_list:
         filename, file_extension = os.path.splitext(support_file)
         print "  Archiving Dependency: " + support_file
         if any(x in file_extension.lower() for x in ['pdf','png','jpeg','jpg','gif']):
            support_file_keep.append(support_file)
         else:
            arlatex_exec_string += ' '+support_file+' '
         
      arlatex_exec_string += '--outfile=nasa-latex-docs.cls'

      # Run the arlatex command
      arlatex = Popen(arlatex_exec_string, shell=True, env=self.ENV, stdout=PIPE, stderr=PIPE)
      arlatex.wait()

      if arlatex.returncode == 0:
         for support_file in support_file_list:
            if support_file not in support_file_keep:
               delete_file(support_file)

      return

   ###################################################################
   # METHOD: runs the export method for creating standalone document
   ###################################################################

   def _export_document(self):
      if not self.args.export:
         return
      
      # Determine the absolute path for the standalone version of document
      export_path    = os.path.join(self.input_dir_path, self.input_bare+'_standalone')  
      support_path   = os.path.join(export_path,'support')
      bib_path       = os.path.join(export_path,'bib')  
      print_status("\nExporting Document To",export_path)  

      # Go to directory where input TeX file is located
      os.chdir(self.input_dir_path)

      # Make sure that the recorder file exists in tmp/
      reorder_file_path = os.path.join(self.ENV['TMPDIR'],self.input_bare+'.fls')
      if not os.path.isfile(reorder_file_path):
         print_error("Recorder file not found in expected location:\n  {0}".format(reorder_file_path))

      # Remove any existing directory 
      if os.path.isdir(export_path):
         shutil.rmtree(export_path)

      doc_folders = []
      for folder, subfolders, files in os.walk(self.input_dir_path):
         if self.ENV['TMPDIR'] not in folder and folder != self.input_dir_path: 
            doc_folders.append(folder.replace(self.input_dir_path,export_path))     

      # Create the necessary directories
      os.makedirs(export_path)
      os.makedirs(support_path)
      for item in doc_folders:
         os.makedirs(item)
      if not os.path.isdir(bib_path):
         os.makedirs(bib_path)
      
      # Parse through the recorder file
      req_files = []
      with open(reorder_file_path) as reorder_file:
         for line in reorder_file:
            
            # Strip the line of any spaces
            line = line.strip()          
            
            # Ignore files from TeX distribution install and any file labeled as "OUTPUT" or "PWD"
            if any(x in line.lower() for x in ['texlive','miktex','output','pwd']):
               continue

            # Remove the INPUT key designator from remaining lines
            line = line.replace('INPUT','').strip()   

            # Make sure each line points to a file that exists, i.e. an absolute path
            if not os.path.isfile(line): 
               continue
            else:
               line =  os.path.abspath(line)

            # Remove any file that is located in self.ENV['TMPDIR']
            if self.ENV['TMPDIR'] in line:  
               continue

            # Add list of required files to list if they are not there yet
            if line not in req_files:
               req_files.append(line)
            else:
               continue   
            
            if line == self.input_abs_path:
               shutil.copyfile(line,os.path.join(export_path,self.input_tex))
               continue
            
            if self.input_dir_path in line:
               line.replace(self.input_dir_path,export_path)
               shutil.copyfile(line,line.replace(self.input_dir_path,export_path))
            else:
               shutil.copyfile(line,os.path.join(support_path,os.path.basename(line)))

      # Make sure any bib files are picked up because recorder option does not show them
      bib_files = []
      bib_files_copy_location = []
      for root, dirs, files in os.walk(self.input_dir_path):
         for file in files:
            if file.endswith(".bib") and self.ENV['TMPDIR'] not in root:
               bib_files.append(os.path.join(root,file))
               bib_files_copy_location.append(os.path.join(bib_path,file))
      # Copy each of the bib files found to their standalone location 
      for bib_file, bib_loc in zip(bib_files,bib_files_copy_location):
         shutil.copyfile(bib_file,bib_loc) 
       
      # Prior to exiting, delete any empty directories that are not needed
      for root, dirs, files in os.walk(export_path,topdown=False):
         for name in dirs:
            fname = os.path.join(root,name)
            try:
               if not os.listdir(fname): #to check wither the dir is empty
                   os.removedirs(fname)
            except:
               pass
               
      # This last portion will attempt to archive everything in support/ using arlatex
      self._run_arlatex(support_path)

      # Copy over this build script to export_path (using copy2 to keep permissions during copy)
      shutil.copy2(self.buildPDF_abs_path,os.path.join(support_path,'buildPDF.py'))
      shutil.copytree(os.path.dirname(self.latexmkrc_abs_path), os.path.join(support_path,'latexmk'))

      return   

   ###################################################################
   # METHOD: class main run method to execute functional code
   ###################################################################

   def run(self):

      # Perform a compatibility check for installed TeX version
      self._get_tex_ver() 

      # Get all variations for the input and output file forms
      self._get_file_forms(self.args.texfile)

      # Create the document template if option given
      self._create_doc_structure()

      # Parse the texfile input to see if TeX Root is defined
      self._get_tex_root()

      # Redefine input to the user specified TeX Root
      self._get_file_forms(self.TeX_Root)

      # Set the environment variables used by latexmk (even on passthrough)
      self._set_environment()

      # Delete the tmp/ directory if this is an archive run   
      export_path    = os.path.join(self.input_dir_path, self.input_bare+'_standalone') 
      # if self.args.export and os.path.isdir(self.ENV['TMPDIR']):
      #    shutil.rmtree(self.ENV['TMPDIR'])
      if self.args.export and os.path.isdir(export_path):
         shutil.rmtree(export_path)

      # Check for existence of tmp/build.out to initialize self.latexmk_returncode
      try: 
         with open(os.path.join(self.ENV['TMPDIR'],'build.out'), 'r') as f:
            self.latexmk_returncode= int(f.readline().strip())
      except:
         self.latexmk_returncode = 0

      # Build the pdf using latexmk - only executes when latexmk_passthrough is False   
      self._run_latexmk()

      # Run pdflatex - only executes when --latexmk-passthrough-build option is True
      self._run_pdflatex()

      # System independent terminal clear
      if self.latexmk_passthrough:
         os.system('cls' if os.name == 'nt' else 'clear')

      if self.latexmk_returncode == 0:
         shutil.copyfile(os.path.join(self.ENV['TMPDIR'],self.input_bare+'.pdf'),self.output_abs_path)
         print_status(tc.GREEN+"\nPDF Built Successfully  ",self.output_abs_path)
         self._print_texfot(False)
      else:
         print_error("No PDF created on last build attempt", exit=False)
         self._print_texfot(True)
         sys.exit(self.latexmk_returncode)

      # Call the export document method  
      self._export_document()

      # Delete the tmp/ directory if user specifies   
      if self.args.clean:
         shutil.rmtree(self.ENV['TMPDIR'])   

      return

###################################################################
# MAIN: Call to __main__
###################################################################

if __name__ == '__main__':
   sys.exit(buildPDF().run())
#!/usr/bin/env python

###################################################
# Import relevant modules
###################################################

import os
import sys
import shutil
import inspect
import argparse
import fileinput
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
# Define print methods
###################################################################

def print_test_banner(title, message, pre=''):

   print(pre + tc.BLUE + tc.BOLD + title + tc.ENDC + ' : ' + message)

def print_test_result(out, err, returncode, verbosity):
   if verbosity:
      print(out)

   if returncode > 0:
      print('  Result: ' + tc.RED + tc.BOLD + 'FAIL' + tc.ENDC)
      print(err)
      sys.exit(1)
   else:
      print('  Result: ' + tc.GREEN + tc.BOLD + 'PASS' + tc.ENDC)

   # print(pre + tc.BOLD + title + tc.ENDC + ' : ' + message)

###################################################################
# Define the main testFunctionality class
###################################################################

class testFunctionality():

   def __init__(self):

      # Get the current environment variables to pass to subprocess
      self.ENV = os.environ.copy()

      # Get path information
      self.verifyCommit_abs_path    = os.path.abspath(os.path.abspath(inspect.getfile(inspect.currentframe())))
      self.verifyCommit_dir_path    = os.path.dirname(self.verifyCommit_abs_path)
      self.buildPDF_abs_path        = os.path.abspath(os.path.join(self.verifyCommit_dir_path,'../../buildPDF.py'))
      self.testFunctionality_dir_path      = os.path.join(self.verifyCommit_dir_path,'testFunctionality')

      argParser = argparse.ArgumentParser(
         usage=tc.BLUE+"\n  python testFunctionality.py"+tc.ENDC,
         description=tc.BOLD+"Description: "+tc.ENDC+ 
         """
         Python script to to test Git repository changes. 
         Tests all functionality of the buildPDF.py script and templates.
         - - - - - - - - -
         GitHub Repository: https://github.com/nasa/nasa-latex-docs
         Comprehensive Doc: https://nasa.github.io/nasa-latex-docs """,
         formatter_class=argparse.RawTextHelpFormatter)

      argParser.add_argument("-v",  "--verbose", action="store_true", 
         help="Verbose option of test output to screen\n ")

      # Parse the user arguments
      self.args = argParser.parse_args() 

      # Remove any existing directory 
      if os.path.isdir(self.testFunctionality_dir_path):
         shutil.rmtree(self.testFunctionality_dir_path)

   ###################################################################
   # METHOD: class main run method to execute functional code
   ###################################################################

   def _change_template_and_test(self,fileName,templateName):
      for line in fileinput.input(fileName, inplace=True):
         if 'documentclass' in line:
            print('\documentclass[{0}]'.format(templateName)+'{nasa-latex-docs}')
         else:
            # This print method avoids a newline from being created
            print "%s" % (line),

      # Test the output of this template       
      print_test_banner('Verify Template   ', 'Test {0} option'.format(templateName))
      test_structure = Popen([self.buildPDF_abs_path,fileName,'--force','--preview'], env=self.ENV, stdout=PIPE, stderr=PIPE)
      test_structure.wait()
      out, err = test_structure.communicate()
      print_test_result(out,err,test_structure.returncode, self.args.verbose)

   ###################################################################
   # METHOD: class main run method to execute functional code
   ###################################################################

   def run(self):

      # Go to directory where input TeX file is located
      os.chdir(self.verifyCommit_dir_path)

      # Test buildPDF.py --structure option
      print_test_banner('Verify buildPDF.py', 'Test --structure option')
      test_structure = Popen([self.buildPDF_abs_path,'testFunctionality.tex','--structure','testFunctionality'], env=self.ENV, stdout=PIPE, stderr=PIPE)
      test_structure.wait()
      out, err = test_structure.communicate()
      print_test_result(out,err,test_structure.returncode, self.args.verbose)

      # Go to the newly created testFunctionality directory
      os.chdir(self.testFunctionality_dir_path)

      # Test buildPDF.py build and verbose option
      print_test_banner('Verify buildPDF.py', 'Test --verbose option')
      test_structure = Popen([self.buildPDF_abs_path,'testFunctionality.tex','--verbose'], env=self.ENV, stdout=PIPE, stderr=PIPE)
      test_structure.wait()
      out, err = test_structure.communicate()
      print_test_result(out,err,test_structure.returncode, self.args.verbose)

      # Test buildPDF.py clean option
      print_test_banner('Verify buildPDF.py', 'Test --clean option')
      test_structure = Popen([self.buildPDF_abs_path,'testFunctionality.tex','--clean'], env=self.ENV, stdout=PIPE, stderr=PIPE)
      test_structure.wait()
      out, err = test_structure.communicate()
      print_test_result(out,err,test_structure.returncode, self.args.verbose)

      # Test buildPDF.py export option
      print_test_banner('Verify buildPDF.py', 'Test --export option')
      test_structure = Popen([self.buildPDF_abs_path,'testFunctionality.tex','--export'], env=self.ENV, stdout=PIPE, stderr=PIPE)
      test_structure.wait()
      out, err = test_structure.communicate()
      print_test_result(out,err,test_structure.returncode, self.args.verbose)

      # Test buildPDF.py force option
      print_test_banner('Verify buildPDF.py', 'Test --force option')
      test_structure = Popen([self.buildPDF_abs_path,'testFunctionality.tex','--force','--preview'], env=self.ENV, stdout=PIPE, stderr=PIPE)
      test_structure.wait()
      out, err = test_structure.communicate()
      print_test_result(out,err,test_structure.returncode, self.args.verbose)

      # Test AIAA Journal template
      shutil.copyfile('testFunctionality.tex','testFunctionality_aiaa_journal.tex')
      self._change_template_and_test('testFunctionality_aiaa_journal.tex','template=aiaa-journal')

      # Test AIAA Conference template
      shutil.copyfile('testFunctionality.tex','testFunctionality_aiaa_conference.tex')
      self._change_template_and_test('testFunctionality_aiaa_conference.tex','template=aiaa-conference')

      # Test AIAA Submission template
      shutil.copyfile('testFunctionality.tex','testFunctionality_aiaa_submission.tex')
      self._change_template_and_test('testFunctionality_aiaa_submission.tex','template=aiaa-submission')

      # Test Tech Report template
      shutil.copyfile('testFunctionality.tex','testFunctionality_tech_report.tex')
      self._change_template_and_test('testFunctionality_tech_report.tex','template=tech-report')

###################################################################
# MAIN: Call to __main__
###################################################################

if __name__ == '__main__':
   sys.exit(testFunctionality().run())


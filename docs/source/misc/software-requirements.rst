.. Create reference to page
.. _SoftwareRequirements:

###########################################
Software Requirements
###########################################

.. contents::
   :local:
   :backlinks: none

Overview
###########################################

Two programs are required prior to using this repository: a compatible TeX distribution and a ``Python`` installation. These may already be installed on your computer, for example most Mac OS installations come with ``Python`` pre-installed.

* **TeX Distribution 2015+** (with latest updates)
   
   * If installing from scratch, please see: :ref:`InstallLatex`

* **Python 2.6+**
   
   * If installing from scratch, we recommend the latest `Anaconda <https://www.continuum.io/downloads>`_ distribution of ``Python``

Updating Existing LaTeX Installation
###########################################

If you have ``root`` access on your machine, you may decide to simply just update the existing installation of ``LaTeX``. Each distribution year may be updated. First the package manager is updated by:

::

   tlmgr update --self

Then the actual packages may be updated by:

::

   tlmgr update --all

.. _InstallLatex:

Installing New LaTeX Installation
###########################################

If you do not have ``root`` access on your machine, you can instead install a separate ``LaTeX`` install somewhere else on the machine and update your ``PATH`` to this new install location. New installations of ``LaTeX`` can be found here:

   * Mac OSX: TexLive (MacTeX) Distribution: `TexLive MacTeX <https://tug.org/mactex/mactex-download.html>`_ 
   * Linux: TexLive Distribution: `TexLive Linux <http://www.tug.org/texlive/>`_  
   * Windows: proTeXt (based on MiKTeX) Distribution: `TexLive proTeXt <https://www.tug.org/protext/>`_

      * Please see the note below regarding Perl dependency on Windows

Windows Perl Dependency
===========================================

On Windows, TexLive includes a minimal Perl setup. It is sufficient for running the TexLive infrastructure programs written in Perl, such as the installer and tlmgr, but it is not sufficient to run every Perl script. Scripts that come as part of TeX packages **may require additional modules**. It is not feasible to satisfy all those dependencies.

Therefore, you will need to install a full Perl distribution from the following location:

   * https://www.perl.org/get.html

Once installed, please ensure that your new Perl installation is on your PATH.

# Emacs Makefile for TRAMP
# lisp/Makefile.  Generated from Makefile.in by configure.

# Copyright (C) 1998, 1999, 2000, 2001, 2002, 2003, 2004, 2005, 2006,
#   2007 Free Software Foundation, Inc.

# Author: Kai Gro,A_(Bjohann <kai.grossjohann@gmx.net>
#         Michael Albinus <michael.albinus@gmx.de>
# Keywords: comm, processes

# This file is part of GNU Emacs.

# GNU Emacs is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2, or (at your option)
# any later version.

# GNU Emacs is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with GNU Emacs; see the file COPYING.  If not, write to the
# Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
# Boston, MA 02110-1301, USA.

# This Makefile requires GNU make.

EMACS		= emacs
EMACS_GW	= yes
INSTALL		= install -m644
MKDIR		= @mkdir -p
RM		= -rm -f

prefix		= /usr/local
datadir		= ${prefix}/share
lispdir		= ${datadir}/emacs/site-lisp
DESTDIR		=

CONTRIB_FILES	= 
CLEAN_FILES	= .\\\#* \\\#* .*~ *~ *.aux *.cp *.cps *.diff *.dvi *.elc *.fn *.fns *.html *.info *.ky *.log *.pg *.tmp *.toc *.tp *.vr *.vrs

# trampver.el and tramp.el must be handled first due to dependencies.
LISP_FILES	= trampver.el tramp.el tramp-cache.el tramp-fish.el	\
		  tramp-smb.el tramp-util.el tramp-uu.el tramp-vc.el

# tramp-gw needs Emacs 22.
ifeq ($(EMACS_GW), yes)
  LISP_FILES += tramp-gw.el
endif

# tramp-ftp and tramp-efs are useful for Emacs resp XEmacs only.
ifeq ($(EMACS_INFO), emacs)
  LISP_FILES += tramp-ftp.el
else
  LISP_FILES += tramp-efs.el
endif

INSTALL_FILES	= $(LISP_FILES) $(CONTRIB_FILES) \
		  $(addsuffix .elc, $(basename $(LISP_FILES) $(CONTRIB_FILES)))

EVAL = --eval "(add-to-list 'load-path \".\")"

ifeq ($(EMACS_INFO), emacs)
  EM = $(EMACS) --no-site-file -batch $(EVAL) -f batch-byte-compile
else
  EM = $(EMACS) -vanilla -batch $(EVAL) -f batch-byte-compile
endif


.PHONY: all install clean distclean tramp xemacs

.SUFFIXES: .elc .el

all: $(addsuffix .elc, $(basename $(LISP_FILES) $(CONTRIB_FILES)))

%.elc: %.el
	$(EM) $?

install: all
	$(MKDIR) $(DESTDIR)$(lispdir)
	$(INSTALL) $(INSTALL_FILES) $(DESTDIR)$(lispdir)

clean:
	$(RM) $(CLEAN_FILES)

distclean: clean
	$(RM) $(CONTRIB_FILES)

# Maintainer targets.

tramp: all

xemacs:
	cp $(LISP_FILES) ChangeLog $(XEMACS_TARGET)/lisp

### TODO:

## * Update Tramp's autoladed symbols in loaddefs.el during install.

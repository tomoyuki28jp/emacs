;;; navi2ch-pizaunix.el --- View old Unix board module for Navi2ch.

;; Copyright (C) 2002 by Navi2ch Project

;; Author: Navi2ch Project
;; Keywords: 2ch, network

;; This file is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.

;; This file is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 59 Temple Place - Suite 330,
;; Boston, MA 02111-1307, USA.

;;; Commentary:

;; http://piza.2ch.net/log/unix/0008251/ $B$N(B
;; Unix $BHD2a5n%m%0AR8K$r8+$k$?$a$N(B multibbs module $B$G$9!#(B
;; http://pc.2ch.net/test/read.cgi/unix/972851555/ $B$b;2>H!#(B

;;; Code:
(provide 'navi2ch-pizaunix)
(defconst navi2ch-pizaunix-ident
  "$Id: navi2ch-pizaunix.el,v 1.2 2004/05/02 14:41:52 nanashi Exp $")

(require 'navi2ch-util)
(require 'navi2ch-multibbs)

(defvar navi2ch-pizaunix-func-alist
  '((bbs-p		. navi2ch-pizaunix-p)
    (article-to-url	. navi2ch-pizaunix-article-to-url)
    (article-update	. navi2ch-pizaunix-article-update)))

(defvar navi2ch-pizaunix-variable-alist
  '((coding-system	. shift_jis)))

(navi2ch-multibbs-regist 'pizaunix
			 navi2ch-pizaunix-func-alist
			 navi2ch-pizaunix-variable-alist)

;;-------------

(defun navi2ch-pizaunix-p (uri)
  "URI $B$,(B pizaunix $B$J$i(B non-nil$B$rJV$9!#(B"
  (string-match "http://piza.2ch.net/log/unix/0008251/" uri))

(defun navi2ch-pizaunix-article-to-url
  (board article &optional start end nofirst)
  "BOARD, ARTICLE $B$+$i(B url $B$KJQ49!#(B
START, END, NOFIRST $B$GHO0O$r;XDj$9$k(B"
  (concat "http://piza.2ch.net/log/unix/0008251/"
	  (cdr (assq 'artid article))
	  ".html"))

(defun navi2ch-pizaunix-article-update (board article start)
  "BOARD, ARTICLE $B$KBP1~$9$k%U%!%$%k$r99?7$9$k!#(B"
  (let ((file (navi2ch-article-get-file-name board article))
	(url (concat "http://piza.2ch.net/log/unix/0008251/"
		     (cdr (assq 'artid article))
		     ".dat")))
    (list (navi2ch-net-update-file url file) 'kako)))

;;; navi2ch-pizaunix.el ends here

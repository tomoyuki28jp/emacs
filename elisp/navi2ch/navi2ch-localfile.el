;;; navi2ch-localfile.el --- View localfile for Navi2ch. -*- coding: iso-2022-7bit; -*-

;; Copyright (C) 2002, 2003, 2004, 2005, 2007, 2008 by Navi2ch Project

;; Author: Nanashi San <nanashi@users.sourceforge.net>
;; Part6 $B%9%l$N(B 427 $B$NL>L5$7$5$s(B
;; <http://pc.2ch.net/test/read.cgi/unix/1023884490/427>

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

;; $B$^$:!"(BBBS $B$rMQ0U$7$?$$%G%#%l%/%H%j$r:n$k!#(B
;;  % mkdir /tmp/localfile
;; $B<!$K!"%G%#%l%/%H%j$N%Q!<%_%C%7%g%s$rE,@Z$K@_Dj$9$k!#(B
;;  % chgrp navi2ch /tmp/localfile
;;  % chmod g+w /tmp/localfile
;;  % chmod g+s /tmp/localfile (OS $B$K$h$C$F$OI,MW(B)
;; $B:G8e$K!"FI$_=q$-$7$?$$E[$i$N(B etc.txt $B$K(B
;; ====
;; $B%m!<%+%k%U%!%$%k%F%9%H(B
;; x-localbbs:///tmp/localfile
;; localfile
;; ====
;; $B$N$h$&$K@_Dj$7$F$d$k$H!"%G%#%l%/%H%j(B /tmp/localfile $B$K=q$-9~$_$^$9!#(B

;;; Code:
(provide 'navi2ch-localfile)

(defconst navi2ch-localfile-ident
  "$Id: navi2ch-localfile.el,v 1.24.2.1 2008/08/26 14:08:14 nawota Exp $")

(eval-when-compile (require 'cl))

(require 'navi2ch-http-date)
(require 'navi2ch-multibbs)

(defcustom navi2ch-localfile-cache-name "localfile"
  "*$B%m!<%+%k(B BBS $B$N>pJs$rJ]B8$9$k%G%#%l%/%H%j$NL>A0!#(B
`navi2ch-directory' $B$+$i$NAjBP%Q%9$r;XDj$9$k!#(B"
  :type 'string
  :group 'navi2ch-localfile)

(defcustom navi2ch-localfile-default-file-modes (+ (* 64 7) (* 8 7) 5)
  "*$B%m!<%+%k(B BBS $B$K%U%!%$%k$r=q$-9~$`:]$K;HMQ$9$k(B `default-file-modes'$B!#(B
$B0UL#$,$"$k$N$O(B8$B?J?t$J$N$G@8$GA`:n$9$k;~$OCm0U!#(B"
  :type '(choice (const :tag "$BFCDj%0%k!<%W$NE[$i$N$_$,=q$-$3$a$k(B" (+ (* 64 7) (* 8 7) 5))
		 (const :tag "$B<+J,$N$_$,=q$-$3$a$k(B" (+ (* 64 7) (* 8 5) 5))
		 (const :tag "$BFCDj%0%k!<%W$NE[$i$N$_$,FI$_=q$-$G$-$k(B" (+ (* 64 7) (* 8 5)))
		 (const :tag "$B<+J,$N$_$,FI$_=q$-$G$-$k(B" (* 64 7)))
  :group 'navi2ch-localfile)

(defcustom navi2ch-localfile-default-user-name "$BL>L5$7$5$s(B"
  "*$B%m!<%+%k(B BBS $B$K=q$-9~$`:]$NL>L5$7$NL>A0!#(B"
  :type 'string
  :group 'navi2ch-localfile)

(defvar navi2ch-localfile-regexp "\\`x-localbbs://")
(defvar navi2ch-localfile-use-lock t)
(defvar navi2ch-localfile-lock-name "lockdir_localfile")

(defvar navi2ch-localfile-func-alist
  '((bbs-p		. navi2ch-localfile-p)
    (article-update 	. navi2ch-localfile-article-update)
    (article-to-url	. navi2ch-localfile-article-to-url)
    (url-to-board	. navi2ch-localfile-url-to-board)
    (url-to-article	. navi2ch-localfile-url-to-article)
    (send-message   	. navi2ch-localfile-send-message)
    (send-success-p 	. navi2ch-localfile-send-message-success-p)
    (error-string   	. navi2ch-localfile-error-string)
    (board-update	. navi2ch-localfile-board-update)
    (board-get-file-name . navi2ch-localfile-board-get-file-name)))

(defvar navi2ch-localfile-variable-alist
  (list (cons 'coding-system navi2ch-coding-system)))

(navi2ch-multibbs-regist 'localfile
			 navi2ch-localfile-func-alist
			 navi2ch-localfile-variable-alist)

;;-------------

;; internal functions like bbs.cgi
(defconst navi2ch-localfile-coding-system
  (intern (format "%s-unix" navi2ch-coding-system)))

(defvar navi2ch-localfile-encode-html-tag-alist
  '((">" . "&gt;")
    ("<" . "&lt;")
    ("\n" . "<br>")))

(defvar navi2ch-localfile-subject-file-name "subject.txt")

(defun navi2ch-localfile-lock (dir)
  "`navi2ch-directory' $B$r%m%C%/$9$k!#(B"
  (when navi2ch-localfile-use-lock
    (let ((redo t)
	  error-message)
      (while redo
	(setq redo nil)
	(unless (navi2ch-lock-directory dir navi2ch-localfile-lock-name)
	  (setq error-message "$B%G%#%l%/%H%j$N%m%C%/$K<:GT$7$^$7$?!#(B")
	  (cond ((y-or-n-p (format "%s$B$b$&0lEY;n$7$^$9$+(B? "
				   error-message))
		 (setq redo t))
		((yes-or-no-p (format "%s$B4m81$r>5CN$GB3$1$^$9$+(B? "
				      error-message))
		 nil)
		(t
		 (error "Lock failed"))))))))

(defun navi2ch-localfile-unlock (dir)
  "DIR $B$N%m%C%/$r2r=|$9$k!#(B"
  (when navi2ch-localfile-use-lock
    (navi2ch-unlock-directory dir navi2ch-localfile-lock-name)))

(defmacro navi2ch-localfile-with-lock (directory &rest body)
  "DIRECTORY $B$r%m%C%/$7!"(BBODY $B$r<B9T$9$k!#(B
BODY $B$N<B9T8e$O(B DIRECTORY $B$N%m%C%/$r2r=|$9$k!#(B"
  `(unwind-protect
       (progn
	 (navi2ch-localfile-lock ,directory)
	 ,@body)
     (navi2ch-localfile-unlock ,directory)))

(put 'navi2ch-localfile-with-lock 'lisp-indent-function 1)

(defun navi2ch-localfile-encode-string (string)
  (let* ((alist navi2ch-localfile-encode-html-tag-alist)
	 (regexp (regexp-opt (mapcar 'car alist))))
    (navi2ch-replace-string regexp (lambda (key)
				     (cdr (assoc key alist)))
			    string t)))

(defun navi2ch-localfile-encode-message (from mail time message
					      &optional subject)
  (format "%s<>%s<>%s<>%s<>%s\n"
	  (navi2ch-localfile-encode-string from)
	  (navi2ch-localfile-encode-string mail)
	  (format-time-string "%y/%m/%d %R" time)
	  (navi2ch-localfile-encode-string message)
	  (navi2ch-localfile-encode-string (or subject ""))))

(defun navi2ch-localfile-update-subject-file (directory
					      &optional article-id sage-flag)
  "DIRECTORY $B0J2<$N(B `navi2ch-localfile-subject-file-name' $B$r99?7$9$k!#(B
ARTICLE-ID $B$,;XDj$5$l$F$$$l$P$=$N%"!<%F%#%/%k$N$_$r99?7$9$k!#(B
`navi2ch-localfile-subject-file-name' $B$K;XDj$5$l$?%"!<%F%#%/%k$,L5$$>l(B
$B9g$O(B SUBJECT $B$r;HMQ$9$k!#(BDIRECTORY $B$O8F$S=P$785$G%m%C%/$7$F$*$/$3$H!#(B"
  (if (not article-id)
      (dolist (file (directory-files (expand-file-name "dat" directory)
				     nil "\\`[0-9]+\\.dat\\'"))
	(navi2ch-localfile-update-subject-file
	 directory (file-name-sans-extension file)))
    (let* ((coding-system-for-read navi2ch-localfile-coding-system)
	   (coding-system-for-write navi2ch-localfile-coding-system)
	   (dat-directory (expand-file-name "dat" directory))
	   (article-file (expand-file-name (concat article-id ".dat")
					   dat-directory))
	   (subject-file (expand-file-name navi2ch-localfile-subject-file-name
					   directory))
	   (temp-file (navi2ch-make-temp-file subject-file))
	   subject lines new-line)
      (unwind-protect
	  (progn
	    (with-temp-buffer
	      (insert-file-contents article-file)
	      (setq lines (count-lines (point-min) (point-max)))
	      (goto-char (point-min))
	      (let ((list (split-string (buffer-substring (point-min)
							  (progn
							    (end-of-line)
							    (point)))
					"<>")))
		(setq subject (or (nth 4 list) ""))))
	    (setq new-line
		  (format "%s.dat<>%s (%d)\n" article-id subject lines))
	    (with-temp-file temp-file
	      (if (file-exists-p subject-file)
		  (insert-file-contents subject-file))
	      (goto-char (point-min))
	      (if (re-search-forward (format "^%s\\.dat<>[^\n]+\n"
					     article-id) nil t)
		  (replace-match "")
		(goto-char (point-max))
		(if (and (char-before)
			 (not (= (char-before) ?\n))) ; $BG0$N$?$a(B
		    (insert "\n")))
	      (unless sage-flag
		(goto-char (point-min)))
	      (insert new-line))
	    (rename-file temp-file subject-file t))
	(if (file-exists-p temp-file)
	    (delete-file temp-file))))))

;; $B"-$H$j$"$($:%9%?%V!#>-MhE*$K$O(B SETTING.TXT $B$rFI$`$h$&$K$7$?$$!#(B
(defun navi2ch-localfile-default-user-name (directory)
  "DIRECTORY $B$G$N%G%U%)%k%H$NL>L5$7$5$s$rJV$9!#(B"
  navi2ch-localfile-default-user-name)

(defun navi2ch-localfile-create-thread (directory from mail message subject)
  "DIRECTORY $B0J2<$K%9%l$r:n$k!#(B"
  (if (string= from "")
      (setq from (navi2ch-localfile-default-user-name directory)))
  (navi2ch-with-default-file-modes navi2ch-localfile-default-file-modes
    (navi2ch-localfile-with-lock directory
      (let ((coding-system-for-read navi2ch-localfile-coding-system)
	    (coding-system-for-write navi2ch-localfile-coding-system)
	    (dat-directory (expand-file-name "dat" directory))
	    now article-id file)
	(unless (file-exists-p dat-directory)
	  (make-directory dat-directory t))
	(while (progn
		 (setq now (current-time)
		       article-id (format-time-string "%s" now)
		       file (expand-file-name (concat article-id ".dat")
					      dat-directory))
		 ;; $B$3$3$G%U%!%$%k$r%"%H%_%C%/$K:n$j$?$$$H$3$@$1$I!"(B
		 ;; write-region $B$K(B mustbenew $B0z?t$NL5$$(B XEmacs $B$G$I$&(B
		 ;; $B$d$l$P$$$$$s$@$m$&!#!#!#(B
		 (file-exists-p file))
	  (sleep-for 1))		; $B$A$g$C$HBT$C$F$_$k!#(B
	(with-temp-file file
	  (insert (navi2ch-localfile-encode-message
		   from mail now message subject)))
	(navi2ch-localfile-update-subject-file directory article-id
					       (string-match "sage" mail))))))

(defun navi2ch-localfile-append-message (directory article-id
						   from mail message)
  "DIRECTORY $B$N(B ARTICLE-ID $B%9%l$K%l%9$rIU$1$k!#(B"
  (if (string= from "")
      (setq from (navi2ch-localfile-default-user-name directory)))
  (navi2ch-with-default-file-modes navi2ch-localfile-default-file-modes
    (navi2ch-localfile-with-lock directory
      (let* ((coding-system-for-read navi2ch-localfile-coding-system)
	     (coding-system-for-write navi2ch-localfile-coding-system)
	     (dat-directory (expand-file-name "dat" directory))
	     (file (expand-file-name (concat article-id ".dat")
				     dat-directory))
	     (temp-file (navi2ch-make-temp-file file)))
	(unwind-protect
	    (when (file-readable-p file)
	      (with-temp-file temp-file
		(insert-file-contents file)
		(goto-char (point-max))
		(if (not (= (char-before) ?\n)) ; $BG0$N$?$a(B
		    (insert "\n"))
		(insert (navi2ch-localfile-encode-message
			 from mail (current-time) message)))
	      (rename-file temp-file file t))
	  (if (file-exists-p temp-file)
	      (delete-file temp-file)))
	(navi2ch-localfile-update-subject-file directory article-id
					       (string-match "sage" mail))))))

;; interface functions for multibbs
(defun navi2ch-localfile-p (uri)
  "URI $B$,(B localfile $B$J$i(B non-nil$B$rJV$9!#(B"
  (string-match navi2ch-localfile-regexp uri))

(defun navi2ch-localfile-article-update (board article start)
  "BOARD ARTICLE $B$N5-;v$r99?7$9$k!#(B"
  (let* ((url (navi2ch-article-get-url board article))
	 (file (navi2ch-article-get-file-name board article))
	 (time (or (cdr (assq 'time article))
		   (and (file-exists-p file)
			(navi2ch-http-date-encode (navi2ch-file-mtime file))))))
    (navi2ch-localfile-update-file url file time)))

(defun navi2ch-localfile-article-to-url
  (board article &optional start end nofirst)
  (let* ((uri (cdr (assq 'uri board)))
	 (artid (cdr (assq 'artid article)))
	 url)
    (unless (string= (substring uri -1) "/")
      (setq uri (concat uri "/")))
    (if (null artid)
	uri
      (setq url (concat uri "dat/" artid ".dat/"))
      (when (numberp start)
	(setq start (number-to-string start)))
      (when (numberp end)
	(setq end (number-to-string end)))
      (if (equal start end)
	  (concat url start)
	(concat url
		start (and (or start end) "-") end
		(and nofirst "n"))))))

(defun navi2ch-localfile-url-to-board (url)
  (let (list uri id)
    (cond
     ((string-match
       "\\`\\(x-localbbs://.*/\\([^/]+\\)\\)/dat/[0-9]+\\.dat" url)
      (setq uri (match-string 1 url)
	    id  (match-string 2 url)))
     ((string-match
       "\\`\\(x-localbbs://.*/\\([^/]+\\)\\)/?$" url)
      (setq uri (match-string 1 url)
	    id  (match-string 2 url))))
    (when uri
      (setq uri (concat uri "/"))
      (setq list (cons (cons 'uri uri) list)))
    (when id
      (setq list (cons (cons 'id id) list)))
    list))

(defun navi2ch-localfile-url-to-article (url)
  (let (list)
    (when (string-match
	   "\\`x-localbbs://.*/\\([0-9]+\\)\\.dat/?\\([0-9]+\\)?" url)
      (setq list (cons (cons 'artid (match-string 1 url))
		       list))
      (when (match-string 2 url)
	(setq list (cons (cons 'number
			       (string-to-number (match-string 2 url)))
			 list))))
    list))

(defvar navi2ch-localfile-last-error nil)

(defun navi2ch-localfile-send-message
  (from mail message subject bbs key time board article &optional post)
  (setq navi2ch-localfile-last-error
	(catch 'error
	  (when (= (length message) 0)
	    (throw 'error "$BK\J8$,=q$+$l$F$$$^$;$s!#(B"))
	  (when (and subject
		     (= (length subject) 0))
	    (throw 'error "Subject $B$,=q$+$l$F$$$^$;$s!#(B"))
	  (save-match-data
	    (let* ((url (navi2ch-board-get-url board))
		   directory)
	      (if (string-match (concat navi2ch-localfile-regexp "\\(.+\\)")
				url)
		  (setq directory (file-name-directory (match-string 1 url)))
		(throw 'error "$B2?$+JQ$G$9!#(B"))
	      (if subject
		  ;; $B%9%lN)$F(B
		  (navi2ch-localfile-create-thread directory
						   from mail message subject)
		;; $B%l%9=q$-(B
		(navi2ch-localfile-append-message directory key
						  from mail message))))
	  nil)))

(defun navi2ch-localfile-send-message-success-p (proc)
  (null navi2ch-localfile-last-error))

(defun navi2ch-localfile-error-string (proc)
  navi2ch-localfile-last-error)

(defun navi2ch-localfile-board-update (board)
  (let* ((url (navi2ch-board-get-url board))
	 (file (navi2ch-board-get-file-name board))
	 (time (or (cdr (assq 'time board))
		   (and (file-exists-p file)
			(navi2ch-http-date-encode (navi2ch-file-mtime file))))))
    (navi2ch-localfile-update-file url file time)))

(defun navi2ch-localfile-board-get-file-name (board &optional file-name)
  (let ((uri (navi2ch-board-get-uri board))
	(cache-dir (navi2ch-expand-file-name navi2ch-localfile-cache-name)))
    (when (and uri
	       (string-match
		(concat navi2ch-localfile-regexp "/*\\(.:/\\)?\\(.+\\)") uri))
      (expand-file-name (or file-name
			    navi2ch-board-subject-file-name)
			(expand-file-name (match-string 2 uri) cache-dir)))))

(defun navi2ch-localfile-update-file (url file &optional time &rest args)
  (let ((directory (file-name-directory file)))
    (unless (file-exists-p directory)
      (make-directory directory t)))
  (let (source-file)
    (save-match-data
      (when (string-match (concat navi2ch-localfile-regexp "\\(.+\\)") url)
	(setq source-file (match-string 1 url))))
    (when (and source-file (file-readable-p source-file))
      (message "Checking file...")
      (let* ((mtime (navi2ch-file-mtime source-file))
	     (mtime-string (navi2ch-http-date-encode mtime))
	     header)
	(when time (setq time (navi2ch-http-date-decode time)))
	(setq header (list (cons 'date mtime-string)
			   (cons 'server "localfile")))
	(if (or navi2ch-net-force-update
		(navi2ch-compare-times mtime time)
		(not (file-exists-p file)))
	    (progn
	      (copy-file source-file file t)
	      (setq header (cons (cons 'last-modified mtime-string) header))
	      (message "%supdated" (current-message)))
	  (setq header (navi2ch-net-add-state 'not-updated header))
	  (message "%snot updated" (current-message)))
	header))))

;;; navi2ch-localfile.el ends here

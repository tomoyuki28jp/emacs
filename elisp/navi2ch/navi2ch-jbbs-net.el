;;; navi2ch-jbbs-net.el --- View jbbs.net module for Navi2ch. -*- coding: iso-2022-7bit; -*-

;; Copyright (C) 2002, 2003, 2004 by Navi2ch Project

;; Author:
;; Part5 $B%9%l$N(B 509 $B$NL>L5$7$5$s(B
;; <http://pc.2ch.net/test/read.cgi/unix/1013457056/509>

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

;;

;;; Code:
(provide 'navi2ch-jbbs-net)
(defconst navi2ch-jbbs-net-ident
  "$Id: navi2ch-jbbs-net.el,v 1.20.2.1 2008/08/26 14:08:18 nawota Exp $")

(require 'navi2ch-multibbs)

(defvar navi2ch-jbbs-func-alist
  '((bbs-p		. navi2ch-jbbs-p)
    (subject-callback	. navi2ch-jbbs-subject-callback)
    (article-update 	. navi2ch-jbbs-article-update)
    (article-to-url 	. navi2ch-jbbs-article-to-url)
    (send-message   	. navi2ch-jbbs-send-message)
    (send-success-p 	. navi2ch-jbbs-send-message-success-p)
    (board-update	. navi2ch-jbbs-board-update)))

(defvar navi2ch-jbbs-variable-alist
  (list (cons 'coding-system navi2ch-coding-system)))

(navi2ch-multibbs-regist 'jbbs-net
			 navi2ch-jbbs-func-alist
			 navi2ch-jbbs-variable-alist)

;;-------------

(defun navi2ch-jbbs-p (uri)
  "URI $B$,(B jbbs.net $B$J$i(B non-nil$B$rJV$9!#(B"
  (string-match "http://[^\\.]+\\.jbbs\\.net/" uri))

(navi2ch-multibbs-defcallback navi2ch-jbbs-subject-callback (jbbs-net)
  "subject.txt $B$r<hF@$9$k$H$-(B navi2ch-net-update-file
$B$G;H$o$l$k%3!<%k%P%C%/4X?t(B"
  (while (re-search-forward "\\([0-9]+\\.\\)cgi\\([^\n]+\n\\)" nil t)
    (replace-match "\\1dat\\2"))
  (re-search-backward "\\(\n.*\n\\)")
  (replace-match "\n"))

(defun navi2ch-jbbs-article-update (board article start)
  "BOARD ARTICLE $B$N5-;v$r99?7$9$k!#(B
START $B$,(B non-nil $B$J$i$P%l%9HV9f(B START $B$+$i$N:9J,$r<hF@$9$k!#(B
$BJV$jCM$O(B HEADER$B!#(B"
  (let ((file (navi2ch-article-get-file-name board article))
	(time (cdr (assq 'time article)))
	(url  (navi2ch-jbbs-get-offlaw-url board article))
	(func (and start 'navi2ch-jbbs-article-callback)))
    (navi2ch-net-update-file url file time func nil start)))

(defun navi2ch-jbbs-get-offlaw-url (board article)
  (let ((uri (cdr (assq 'uri board))))
    (string-match "\\(http://[^/]+/[^/]+/\\)\\([0-9]+\\)" uri )
    (format "%sbbs/offlaw.cgi?BBS=%s&KEY=%s"
	    (match-string 1  uri) (match-string 2 uri)
	    (cdr (assq 'artid article)))))

(defun navi2ch-jbbs-article-to-url (board article &optional start end nofirst)
  "BOARD, ARTICLE $B$+$i(B url $B$KJQ49!#(B
START, END, NOFIRST $B$GHO0O$r;XDj$9$k(B"
  (let ((uri   (cdr (assq 'uri board)))
	(artid (cdr (assq 'artid article))))
    (string-match "\\(.*\\)\\/\\([^/]*\\)\\/" uri)
    (concat
     (format "%s/bbs/read.cgi?BBS=%s&KEY=%s"
	     (match-string 1 uri) (match-string 2 uri) artid)
     (if (and (stringp start)
	      (string-match "l\\([0-9]+\\)" start))
	 (format "&LAST=%s" (match-string 1 start))
       (concat
	(and start (format "&START=%d" start))
	(and end (format "&END=%d" end))))
     (and nofirst
	  (not (eq start 1))
	  "&NOFIRST=TRUE"))))

(defconst navi2ch-jbbs-url-regexp
  ;;    prefix   $B%+%F%4%j(B     BBS$BHV9f(B
  "\\`\\(.+\\)/\\([^/]+\\)/\\([^/]+\\)/\\'")

(defun navi2ch-jbbs-get-writecgi-url (board)
  "write.cgi $B$N(B url $B$rJV$9!#(B"
  (let ((uri (navi2ch-board-get-uri board)))
    (and (string-match navi2ch-jbbs-url-regexp uri)
	 (format "%s/%s/bbs/write.cgi"
		 (match-string 1 uri)
		 (match-string 2 uri)))))

(defun navi2ch-jbbs-send-message
  (from mail message subject bbs key time board article &optional post)
  (let ((url         (navi2ch-jbbs-get-writecgi-url board))
	(referer     (navi2ch-board-get-uri board))
	(param-alist (list
		      (cons "submit" "$B=q$-9~$`(B")
		      (cons "NAME" (or from ""))
		      (cons "MAIL" (or mail ""))
		      (cons "MESSAGE" message)
		      (cons "BBS" bbs)
		      (cons "KEY" key)
		      (cons "TIME" time))))
    (navi2ch-net-send-request
     url "POST"
     (list (cons "Content-Type" "application/x-www-form-urlencoded")
	   (cons "Cookie" (concat "NAME=" from "; MAIL=" mail))
	   (cons "Referer" referer))
     (navi2ch-net-get-param-string param-alist))))

(defun navi2ch-jbbs-send-message-success-p (proc)
  (string-match "302 Found" (navi2ch-net-get-content proc)))

;;-------------
(defvar navi2ch-jbbs-parse-regexp "\
<dt>\\([0-9]+\\) $BL>A0!'(B\\(<a href=\"mailto:\\([^\"]*\\)\">\\|<[^>]+>\\)\
<b> \\(.*\\) </b><[^>]+> $BEj9FF|!'(B \\(.*\\)<br><dd>\\(.*\\)<br><br>\n")

(defun navi2ch-jbbs-parse ()
  (let ((case-fold-search t))
    (re-search-forward navi2ch-jbbs-parse-regexp nil t)))

(defun navi2ch-jbbs-make-article ()
  (let ((mail (match-string 3))
	(name (match-string 4))
	(date (match-string 5))
	(contents (match-string 6)))
    ;; $B:9J,$NA0$N%;%Q%l!<%?$,(B "," $B$G8e$,(B "<>" $B$K$J$k$N$,$A$g$C$H%$%d!#(B
    (format "%s<>%s<>%s<>%s<>\n"
	    name (or mail "") date contents )))

(navi2ch-multibbs-defcallback navi2ch-jbbs-article-callback (jbbs-net)
  (let ((beg (point))
	(max-num 0)
	alist num min-num)
    (while (navi2ch-jbbs-parse)
      (setq num (string-to-number (match-string 1))
	    min-num (or min-num num)
	    max-num (max max-num num)
	    alist (cons (cons (string-to-number (match-string 1))
			      (navi2ch-jbbs-make-article))
			alist)))
    (delete-region beg (point-max))
    (when (and min-num max-num)
      (let ((i min-num))
	(while (<= i max-num)
	  (insert (or (cdr (assoc i alist))
		      "$B$"$\!<$s(B<>$B$"$\!<$s(B<>$B$"$\!<$s(B<>$B$"$\!<$s(B<>\n"))
	  (setq i (1+ i)))))))

(defun navi2ch-jbbs-board-update (board)
  (let ((url (navi2ch-board-get-url board))
	(file (navi2ch-board-get-file-name board))
	(time (cdr (assq 'time board)))
	(func (navi2ch-multibbs-subject-callback board)))
    (navi2ch-net-update-file url file time func)))

;;; navi2ch-jbbs-net.el ends here

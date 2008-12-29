;;; navi2ch-machibbs.el --- View machiBBS module for Navi2ch. -*- coding: iso-2022-7bit; -*-

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
(provide 'navi2ch-machibbs)
(defconst navi2ch-machibbs-ident
  "$Id: navi2ch-machibbs.el,v 1.29.2.1 2008/08/26 14:08:14 nawota Exp $")

(eval-when-compile (require 'cl))
(require 'navi2ch-multibbs)

(defvar navi2ch-machibbs-func-alist
  '((bbs-p		. navi2ch-machibbs-p)
    (subject-callback	. navi2ch-machibbs-subject-callback)
    (article-update 	. navi2ch-machibbs-article-update)
    (article-to-url 	. navi2ch-machibbs-article-to-url)
    (url-to-board   	. navi2ch-machibbs-url-to-board)
    (url-to-article 	. navi2ch-machibbs-url-to-article)
    (send-message   	. navi2ch-machibbs-send-message)
    (send-success-p 	. navi2ch-machibbs-send-message-success-p)
    (board-update	. navi2ch-machibbs-board-update)))

(defvar navi2ch-machibbs-variable-alist
  (list (cons 'coding-system navi2ch-coding-system)))

(navi2ch-multibbs-regist 'machibbs
			 navi2ch-machibbs-func-alist
			 navi2ch-machibbs-variable-alist)

;; (defvar navi2ch-machibbs-subject-max-bytes 5000
;;   "$B%9%l$N0lMw$r$I$l$@$1I=<($9$k$+!#(B
;; 0$B$N>l9g$OA4$FI=<($9$k!#(B")

;;-------------

(defun navi2ch-machibbs-p (uri)
  "URI $B$,(B machibbs $B$J$i(B non-nil$B$rJV$9!#(B"
  (or (string-match "http://[^\\.]+\\.machibbs\\.com/" uri)
      (string-match "http://[^\\.]+\\.machi\\.to/" uri)))

;; (defun navi2ch-machibbs-subject-callback (string)
;;   "subject.txt $B$r<hF@$9$k$H$-(B navi2ch-net-update-file
;; $B$G;H$o$l$k%3!<%k%P%C%/4X?t(B"
;;   (let ((sub-string (if (> navi2ch-machibbs-subject-max-bytes 0)
;; 			(substring string 0 navi2ch-machibbs-subject-max-bytes)
;; 		      string)))
;;     (navi2ch-replace-string
;;      "\\([0-9]+\\.\\)cgi\\([^\n]+\n\\)" "\\1dat\\2" sub-string t)))

(navi2ch-multibbs-defcallback navi2ch-machibbs-subject-callback (machibbs)
  "subject.txt $B$r<hF@$9$k$H$-(B navi2ch-net-update-file
$B$G;H$o$l$k%3!<%k%P%C%/4X?t(B"
  (while (re-search-forward "\\([0-9]+\\.\\)cgi\\([^\n]+\n\\)" nil t)
    (replace-match "\\1dat\\2")))

(defun navi2ch-machibbs-article-update (board article start)
  "BOARD ARTICLE $B$N5-;v$r99?7$9$k!#(B
START $B$,(B non-nil $B$J$i$P%l%9HV9f(B START $B$+$i$N:9J,$r<hF@$9$k!#(B
$BJV$jCM$O(B HEADER$B!#(B"
  (let ((file (navi2ch-article-get-file-name board article))
	(time (cdr (assq 'time article)))
	(url  (navi2ch-machibbs-article-to-url board article start nil start))
	(func (if start 'navi2ch-machibbs-article-callback-diff
		'navi2ch-machibbs-article-callback)))
    (navi2ch-net-update-file url file time func nil start)))

(defun navi2ch-machibbs-article-to-url (board article &optional start end nofirst)
  "BOARD, ARTICLE $B$+$i(B url $B$KJQ49!#(B
START, END, NOFIRST $B$GHO0O$r;XDj$9$k(B" ; $B8z$+$J$+$C$?$i65$($F$/$@$5$$!#(B
  (let ((uri   (cdr (assq 'uri board)))
	(artid (cdr (assq 'artid article))))
    (string-match "\\(.*\\)\\/\\([^/]*\\)\\/" uri) ; \\/ --> / ?
    (concat
     (format "%s/bbs/read.pl?BBS=%s&KEY=%s"
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

(defun navi2ch-machibbs-url-to-board (url)
  "url $B$+$i(B BOARD $B$KJQ49!#(B"
  (cond
   ;; http://www.machi.to/bbs/read.pl?BBS=tawara&KEY=1059722839
   ;; http://tohoku.machi.to/bbs/read.pl?BBS=touhoku&KEY=1062265542
   ((string-match
     "http://\\(.+\\)/bbs/read\\..*BBS=\\([^&]+\\)"
     url)
    (list (cons 'uri (format "http://%s/%s/"
			     (match-string 1 url)
			     (match-string 2 url)))
	  (cons 'id  (match-string 2 url))))
   ;; http://hokkaido.machi.to/bbs/read.cgi/hokkaidou/
   ((string-match
     "http://\\([^/]+\\)/bbs/read.cgi/\\([^/]+\\)/"
     url)
    (list (cons 'uri (format "http://%s/%s/"
			     (match-string 1 url)
			     (match-string 2 url)))
	  (cons 'id  (match-string 2 url))))
   ;; http://www.machi.to/tawara/
   ;; http://tohoku.machi.to/touhoku/
   ((string-match
     "http://\\([^/]+\\)/\\([^/]+\\)"
     url)
    (list (cons 'uri (format "http://%s/%s/"
			     (match-string 1 url)
			     (match-string 2 url)))
	  (cons 'id  (match-string 2 url))))))

(defun navi2ch-machibbs-url-to-article (url)
  (cond ((string-match
	  "http://.+/bbs/read\\..*KEY=\\([0-9]+\\)"
	  url)
	 (list (cons 'artid (match-string 1 url))))
	((string-match
	  "http://[^/]+/bbs/read.cgi/[^/]+/\\([0-9]+\\)"
	  url)
	 (list (cons 'artid (match-string 1 url))))))

(defun navi2ch-machibbs-send-message
  (from mail message subject bbs key time board article &optional post)
  (let ((url          (navi2ch-machibbs-get-writecgi-url board))
	(referer      (navi2ch-board-get-uri board))
	(param-alist  (list
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
	   (cons "Referer" referer))
     (navi2ch-net-get-param-string param-alist))))

(defun navi2ch-machibbs-get-writecgi-url (board)
  (let ((uri (navi2ch-board-get-uri board)))
    (string-match "\\(.+\\)/[^/]+/$" uri)
    (format "%s/bbs/write.cgi" (match-string 1 uri))))

(defun navi2ch-machibbs-send-message-success-p (proc)
  (string-match "302 Found" (navi2ch-net-get-content proc)))

;; -- parse html --
(defvar navi2ch-machibbs-parse-regexp "\
<dt>\\([0-9]+\\) ?$BL>A0!'(B\\(<a href=\"mailto:\\([^\"]*\\)\"><b> ?\\|<font[^>]*>\
<b> ?\\)\\(.*\\) ?</b>.+ ?$BEj9FF|!'(B ?\\(.*\\)\\(\n\\( ?]</font>\\)\\)?<br>\
<dd> ?\\(.*\\) ?<br><br>$")
(defvar navi2ch-machibbs-parse-subject-regexp "<title>\\(.*\\)</title>")

(defun navi2ch-machibbs-parse-subject ()
  (let ((case-fold-search t))
    (re-search-forward navi2ch-machibbs-parse-subject-regexp nil t)
    (match-string 1)))

(defun navi2ch-machibbs-parse ()
  (let ((case-fold-search t))
    (re-search-forward navi2ch-machibbs-parse-regexp nil t)))

(defun navi2ch-machibbs-make-article (&optional subject)
  (let ((mail (match-string 3))
	(name (match-string 4))
	(date (match-string 5))
	(date-tail (match-string 7))
	(contents (match-string 8)))
    (format "%s<>%s<>%s<>%s<>%s\n"
	    name (or mail "") (concat date (or date-tail ""))
	    contents (or subject ""))))

(navi2ch-multibbs-defcallback navi2ch-machibbs-article-callback
    (machibbs &optional diff)
  (let ((beg (point))
	(max-num 0)
	subject alist num min-num)
    (unless diff
      (setq subject (navi2ch-machibbs-parse-subject)))
    (while (navi2ch-machibbs-parse)
      (setq num (string-to-number (match-string 1))
	    min-num (or min-num num)
	    max-num (max max-num num)
	    alist (cons (cons (string-to-number (match-string 1))
			      (navi2ch-machibbs-make-article subject))
			alist)
	    subject nil))
    (delete-region beg (point-max))
    (when (and min-num max-num)
      (let ((i min-num))
	(while (<= i max-num)
	  (insert (or (cdr (assoc i alist))
		      "$B$"$\!<$s(B<>$B$"$\!<$s(B<>$B$"$\!<$s(B<>$B$"$\!<$s(B<>\n"))
	  (setq i (1+ i)))))))

(defun navi2ch-machibbs-article-callback-diff ()
  (navi2ch-machibbs-article-callback t))

(defun navi2ch-machibbs-board-update (board)
  (let ((url (navi2ch-board-get-url board))
	(file (navi2ch-board-get-file-name board))
	(time (cdr (assq 'time board)))
	(func (navi2ch-multibbs-subject-callback board)))
    (navi2ch-net-update-file url file time func)))

;;; navi2ch-machibbs.el ends here

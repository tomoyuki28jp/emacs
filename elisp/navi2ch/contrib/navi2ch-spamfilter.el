;;; navi2ch-spamfilter.el --- Navi2ch interface for spamfilter.el

;; Copyright (C) 2003, 2004 by Navi2ch Project
;; Copyright (C) 2003 http://pc.2ch.net/test/read.cgi/unix/1065246418/38

;; Author: http://pc.2ch.net/test/read.cgi/unix/1065246418/38
;; Keywords: 2ch, network, spam

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

;; $B;H$$J}(B
;; http://www.geocities.co.jp/SiliconValley-PaloAlto/7043/#spamfilter.el
;; $B$+$i(B spamfilter $B%Q%C%1!<%8$rF~<j$7$F%$%s%9%H!<%k$7$F$*$/!#(B
;; ~/.navi2ch/init.el $B$G(B
;; (require 'navi2ch-spamfilter)
;; $B$H$G$b$7$F!"(BNavi2ch $B$N<B9T;~$KFI$_9~$`$h$&$K$9$k!#(B
;; $B$^$:$O%3!<%Q%9$N3X=,$r$9$k!#E,Ev$J%9%l$r3+$-!"(Bspam $B$r(B "d" $B$7$F(B hide
;; $B%^!<%/$rIU$1!"(Bspam $B0J30$O(B hide $B%b!<%I$G(B "d" $B$7$F(B hide $B%^!<%/$,IU$$(B
;; $B$F$J$$>uBV$K$9$k!#$3$N>uBV$G(B M-x navi2ch-article-register-to-corpus
;; $B$H$7!"%^!<%/$K1~$8$F%3!<%Q%9$KEPO?$7$F$d$k!#(B
;; $B$"$kDxEY%3!<%Q%9$,0i$C$?$i(B ~/.navi2ch/init.el $B$K(B
;; (navi2ch-spamf-enable) $B$r2C$($F<+F0E*$K%U%#%k%?$9$k$h$&$K$9$k!#(B
;; $B8mG'<1$,>/$J$/$J$C$?$i(B navi2ch-article-auto-spam-register-by-filter
;; $B$r(B non-nil $B$K@_Dj$7!"%U%#%k%?$N7k2L$K1~$8$F%3!<%Q%9$K:FEPO?$9$k!#(B

;;; Code:
(defconst navi2ch-spamfilter-ident
  "$Id: navi2ch-spamfilter.el,v 1.12 2004/05/02 14:41:52 nanashi Exp $")

(eval-when-compile (require 'cl))
(require 'spamfilter)
(require 'navi2ch)

(defconst navi2ch-spamf-preferred-major 1)
(defconst navi2ch-spamf-preferred-minor 10)

(unless (and (boundp 'spamf-cvs-id)
	     (string-match "\\([0-9]+\\)\\.\\([0-9]+\\)" spamf-cvs-id)
	     (let ((major (string-to-number (match-string 1 spamf-cvs-id)))
		   (minor (string-to-number (match-string 2 spamf-cvs-id))))
	       (or (> major navi2ch-spamf-preferred-major)
		   (and (= major navi2ch-spamf-preferred-major)
			(>= minor navi2ch-spamf-preferred-minor)))))
  (error "Use spamfilter.el revision %d.%d or later."
	 navi2ch-spamf-preferred-major
	 navi2ch-spamf-preferred-minor))

(defvar navi2ch-article-bayesian-save-file-name
  (expand-file-name "spamfilter" navi2ch-directory))

(defvar navi2ch-article-auto-spam-register-by-filter nil
  "non-nil $B$N>l9g!"%U%#%k%?$N7k2L$r%3!<%Q%9$K:FEPO?$9$k!#(B
$B<+F0E*$K1#$5$l$?%l%9$N(B spam $B$C$]$5$OA}2C$7!"1#$5$l$J$+$C$?%l%9$N(B spam
$B$C$]$5$O8:>/$9$k!#(B
non-nil $B$N$^$^$G8mH=Dj$rJ|CV$9$k$H8m$C$?3X=,$r$7$F$7$^$&$N$GCm0U!#(B")

(defvar navi2ch-article-manual-spam-ratio
  (if navi2ch-article-auto-spam-register-by-filter 2 1)
  "$B<jF0$G(B spam $BEPO?(B / $B2r=|$r$7$?:]$NG\N(!#(B
navi2ch-article-message-filter-by-bayesian $B$G<+F0EPO?$9$k>l9g$O(B 2 $B0J>e(B
$B$K$7$F$*$$$?J}$,$$$$$H;W$&!#(B")

(defvar navi2ch-article-register-normal-message-as-good t
  "non-nil $B$N>l9g!"%^!<%/$NIU$$$F$J$$%l%9$b(B good $B$H$7$FEPO?$9$k!#(B
`navi2ch-article-register-to-corpus' $B$b;2>H!#(B")

(defvar navi2ch-spamf-good-corpus
  (make-spamf-corpus :name "navi2ch-spamf-good-corpus"
		     :table (make-hash-table :test #'eq)
		     :message-count 0))

(defvar navi2ch-spamf-bad-corpus
  (make-spamf-corpus :name "navi2ch-spamf-bad-corpus"
		     :table (make-hash-table :test #'eq)
		     :message-count 0))

(defvar navi2ch-article-before-save-corpus-hook nil)

(defvar navi2ch-spamf-additional-token-flag nil
  "non-nil $B$N>l9g!"%l%9$NF|;~!"HV9fEy$r%H!<%/%s$H$7$FDI2C$9$k!#(B
$B7P83$G$O!"%3!<%Q%9$,Bg$-$/$J$k3d$K8z2L$OGv$$$H;W$o$l$k!#(B")

(dolist (map (list navi2ch-article-mode-map navi2ch-popup-article-mode-map))
  (define-key map "\C-c\C-g"
    'navi2ch-article-add-message-filter-by-bayesian-good)
  (define-key map "\C-c\C-b"
    'navi2ch-article-add-message-filter-by-bayesian-spam)
  (define-key map "\C-c\C-s"
    'navi2ch-article-show-spam-probability))

(defsubst navi2ch-spamf-register-token (corpus token)
  (spamf-increase-word-count corpus (spamf-intern token))
  (incf (spamf-corpus-message-count corpus)))

(defsubst navi2ch-spamf-register-good-token (token)
  (interactive "MToken: ")
  (navi2ch-spamf-register-token navi2ch-spamf-good-corpus token))

(defsubst navi2ch-spamf-register-spam-token (token)
  (interactive "MToken: ")
  (navi2ch-spamf-register-token navi2ch-spamf-bad-corpus token))

(defsubst navi2ch-spamf-register-token-list (corpus list)
  (dolist (token list)
    (spamf-increase-word-count corpus (spamf-intern token)))
  (incf (spamf-corpus-message-count corpus)))

(defsubst navi2ch-spamf-register-good-token-list (list)
  (navi2ch-spamf-register-token-list navi2ch-spamf-good-corpus list))

(defsubst navi2ch-spamf-register-spam-token-list (list)
  (navi2ch-spamf-register-token-list navi2ch-spamf-bad-corpus list))

(defun navi2ch-article-bayesian-tokenizer (alist)
  (nconc
   (funcall spamf-tokenize-string-function
	    (cdr (assq 'data alist)))
   (if navi2ch-spamf-additional-token-flag
       (mapcar (lambda (str)
		 (concat "date:" str))
	       (split-string (cdr (assq 'date alist)) "[ $B!!(B]+")))
   (if (string-match "$B"!(B[^ ]+" (cdr (assq 'name alist)))
       (list (concat "trip:" (match-string 0 (cdr (assq 'name alist))))))
   (let ((number (or (cdr (assq 'number alist))
		     (navi2ch-article-get-current-number))))
     (when (and navi2ch-spamf-additional-token-flag
		(numberp number))
       (list (concat "num:"  (number-to-string number)))))
   (list
    (concat "mail:" (cdr (assq 'mail alist)))
    (concat "name:" (cdr (assq 'name alist))))))

(defsubst navi2ch-article-tokenize-current-message ()
  (navi2ch-article-bayesian-tokenizer
   (navi2ch-article-get-message
    (navi2ch-article-get-current-number))))

(defun navi2ch-article-add-message-filter-by-bayesian-good ()
  (interactive)
  (dotimes (i navi2ch-article-manual-spam-ratio)
    (navi2ch-spamf-register-good-token-list
     (navi2ch-article-tokenize-current-message))))

(defun navi2ch-article-add-message-filter-by-bayesian-spam ()
  (interactive)
  (dotimes (i navi2ch-article-manual-spam-ratio)
    (navi2ch-spamf-register-spam-token-list
     (navi2ch-article-tokenize-current-message))))

(defsubst navi2ch-article-spam-probability (token)
  (spamf-sum-spam-probability
   (mapcar #'cdr (spamf-cutoff-words token
				     spamf-cutoff-words-limit
				     navi2ch-spamf-good-corpus
				     navi2ch-spamf-bad-corpus))))

(defun navi2ch-article-show-spam-probability (&optional prefix)
  "$B%l%9$N(B spam $B$C$]$5$rI=<($9$k!#(B"
  (interactive "P")
  (let* ((token (navi2ch-article-tokenize-current-message))
	 (prob (navi2ch-article-spam-probability token)))
    (if prefix
	(with-output-to-temp-buffer "*spam probability*"
	  (princ (format "Spam probability: %f\n\n" prob))
	  (dolist (pair (spamf-cutoff-words token
					    spamf-cutoff-words-limit
					    navi2ch-spamf-good-corpus
					    navi2ch-spamf-bad-corpus))
	    (prin1 (cons (symbol-name (car pair)) (cdr pair)))
	    (princ "\n")))
      (message "Spam probability: %f" prob))))

(defun navi2ch-article-message-filter-by-bayesian (alist)
  (let ((token (navi2ch-article-bayesian-tokenizer alist)))
    (if (> (navi2ch-article-spam-probability token)
	   spamf-spamness-limit)
	'hide)))

(defun navi2ch-article-save-corpus ()
  (run-hooks 'navi2ch-article-before-save-corpus-hook)
  (message "Saving corpus file...")
  (spamf-save-corpus navi2ch-article-bayesian-save-file-name
		     navi2ch-spamf-good-corpus
		     navi2ch-spamf-bad-corpus)
  (message "Saving corpus file...done"))

(defun navi2ch-article-load-corpus ()
  (message "Loading corpus file...")
  (spamf-load-corpus navi2ch-article-bayesian-save-file-name)
  (message "Loading corpus file...done"))

(defun navi2ch-article-register-to-corpus ()
  "$B%l%9$N%^!<%/$K1~$8$F8=:_$N%9%l$r%3!<%Q%9$KEPO?$9$k!#(B
important $B%^!<%/$N%l%9$r(B good $B$K!"(Bhide $B%^!<%/$N%l%9$r(B bad $B$KEPO?$9$k!#(B
`navi2ch-article-register-normal-message-as-good' $B$,(B non-nil $B$N>l9g$O(B
$B%^!<%/$NIU$$$F$J$$%l%9$b(B good $B$KEPO?$9$k!#(B"
  (interactive)
  (let ((hide (cdr (assq 'hide navi2ch-article-current-article)))
	(imp (cdr (assq 'important navi2ch-article-current-article))))
    (dolist (x navi2ch-article-message-list)
      (let ((num (car x))
	    (alist (cdr x)))
	(if (stringp alist)
	    (setq alist (navi2ch-article-parse-message alist)))
	(message "registering...%d" num)
	(cond ((memq num hide)
	       (navi2ch-spamf-register-spam-token-list
		(navi2ch-article-bayesian-tokenizer alist)))
	      ((or (memq num imp)
		   navi2ch-article-register-normal-message-as-good)
	       (navi2ch-spamf-register-good-token-list
		(navi2ch-article-bayesian-tokenizer alist))))))
    (message "registering...done")))

;; hook and advice
(add-hook 'navi2ch-save-status-hook #'navi2ch-article-save-corpus)
(add-hook 'navi2ch-hook #'navi2ch-article-load-corpus)

(defadvice navi2ch-article-apply-message-filters
  (after navi2ch-article-register-spam-by-filter (alist))
  (when navi2ch-article-auto-spam-register-by-filter
    (let ((token (navi2ch-article-bayesian-tokenizer alist)))
      (if (eq ad-return-value 'hide)
	  (navi2ch-spamf-register-spam-token-list token)
	(navi2ch-spamf-register-good-token-list token))))
  ad-return-value)

(defadvice navi2ch-article-hide-message
  (before navi2ch-article-hide-message-as-spam)
  (navi2ch-article-add-message-filter-by-bayesian-spam))

(defadvice navi2ch-article-cancel-hide-message
  (before navi2ch-article-cancel-hide-message-as-good)
  (navi2ch-article-add-message-filter-by-bayesian-good))

(defadvice navi2ch-article-next-message
  (before navi2ch-article-next-message-as-good)
  (unless navi2ch-article-hide-mode
    (navi2ch-article-add-message-filter-by-bayesian-good)))

(defconst navi2ch-spamf-advice-list
  '((navi2ch-article-apply-message-filters
     after
     navi2ch-article-register-spam-by-filter)
    (navi2ch-article-hide-message
     before
     navi2ch-article-hide-message-as-spam)
    (navi2ch-article-cancel-hide-message
     before
     navi2ch-article-cancel-hide-message-as-good)
    ;; (navi2ch-article-next-message
    ;;  before
    ;;  navi2ch-article-next-message-as-good)
    ))

(defun navi2ch-spamf-enable ()
  "spamfilter $B$rM-8z$K$9$k!#(B
$B%Y%$%8%"%s%U%#%k%?$K$h$k<+F0%U%#%k%?%j%s%0!"%-!<$K$h$k<+F0%9%3%"%j%s%0$,(B
$BM-8z$K$J$k!#(B"
  (interactive)
  (dolist (advice navi2ch-spamf-advice-list)
    (apply #'ad-enable-advice advice)
    (ad-activate (car advice)))
  (add-to-list 'navi2ch-article-message-filter-list
	       #'navi2ch-article-message-filter-by-bayesian))

(defun navi2ch-spamf-disable ()
  "spamfilter $B$rL58z$K$9$k!#(B
$B%Y%$%8%"%s%U%#%k%?$K$h$k<+F0%U%#%k%?%j%s%0!"%-!<$K$h$k<+F0%9%3%"%j%s%0$,(B
$BL58z$K$J$k!#(B"
  (interactive)
  (dolist (advice navi2ch-spamf-advice-list)
    (apply #'ad-disable-advice advice)
    (ad-activate (car advice)))
  (setq navi2ch-article-message-filter-list
	(delq #'navi2ch-article-message-filter-by-bayesian
	      navi2ch-article-message-filter-list)))

(provide 'navi2ch-spamfilter)
;;; navi2ch-spamfilter.el ends here

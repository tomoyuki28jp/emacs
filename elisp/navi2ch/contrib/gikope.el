;;; gikope.el --- Ascii-Art handling tool

;; Copyright 2002 knok <knok@users.sourceforge.net>
;; License: GPL
;; $Id: gikope.el,v 1.4 2002/10/01 12:48:48 taiki Exp $

;; related resources
;;; gikope http://go.to/gikope

(eval-when-compile (require 'cl))

;;; Variables
;; customizable variables
(defvar gikope-aa-file "~/.navi2ch/mojidata.txt"
  "$B%.%3%ZMQ%G!<%?%U%!%$%k(B")
(defvar gikope-aa-file-coding 'shift_jis-dos
  "$B%.%3%ZMQ%G!<%?%U%!%$%k$N%(%s%3!<%G%#%s%0(B")

;; global variables
(defvar gikope-aa-location-alist '()
  "$B%.%3%ZMQ%G!<%?%U%!%$%k$NL>>N$H0LCV$rJ]B8$9$k(B alist")
(defvar gikope-aa-buffer "*gikope*"
  "$B%.%3%ZMQ%G!<%?%U%!%$%k$rFI$_$3$s$@%P%C%U%!(B")
(defvar gikope-aa-history nil
  "gikope-copy-to-killring-aa $BMQ%R%9%H%j(B")
(defvar gikope-aa-begin-regex "^\\[MojieName=\\(.*\\)\\]$"
  "$B%.%3%Z%G!<%?(B $B%(%s%H%j3+;OItJ,$N@55,I=8=(B")
(defvar gikope-aa-end-regex "^\\[END\\]$"
  "$B%.%3%Z%G!<%?(B $B%(%s%H%j=*N;ItJ,$N@55,I=8=(B")

(defvar gikope-window-configuration nil)


;; gikope-list variables
(defvar gikope-list-buffer-name "*gikope list*" "AA $B0lMw%P%C%U%!$NL>A0(B")
(defvar gikope-list-window-width 20 "AA $B0lMw%P%C%U%!$NI}(B")

;; gikope-view variables
(defvar gikope-view-buffer-name "*gikope view*" "AA $BI=<(%P%C%U%!$NL>A0(B")
(defvar gikope-view-aa-name nil "$B8=:_I=<($7$F$$$k(B AA $B$NL>A0(B")

;;; Key Binds
;; gikope-list key binds
(defvar gikope-list-mode-map nil)
(unless gikope-list-mode-map
  (let ((map (make-sparse-keymap)))
    (define-key map "\r" 'gikope-list-select)
    (define-key map "." 'gikope-list-select)
    (define-key map " " 'gikope-list-select)
    (define-key map "n" 'next-line)
    (define-key map "p" 'previous-line)
    (define-key map "q" 'gikope-exit)
    (define-key map "1" 'delete-other-windows)
    (define-key map "w" 'gikope-list-copy)
    (setq gikope-list-mode-map map)))

;; gikope-view key binds
(defvar gikope-view-mode-map nil)
(unless gikope-view-mode-map
  (let ((map (make-sparse-keymap)))
    (define-key map "q" 'gikope-exit)
    (define-key map "w" 'gikope-view-copy)
    (define-key map "1" 'delete-other-windows)
    (setq gikope-view-mode-map map)))

;;; Functions
;; insert
(defun gikope-copy-to-killring-aa (&optional arg)
  "$B%"%9%-!<%"!<%H$r(B kill-ring $B$KF~$l$k(B"
  (interactive "P")
  (unless gikope-aa-location-alist
    (gikope-parse-aa))
  (let ((aa-location-alist gikope-aa-location-alist))
    (if arg
	(let (re)
	  (setq re (read-string "Regex: "))
	  (setq aa-location-alist (gikope-get-matched-aa-alist re))))
    (gikope-copy-aa (completing-read
		     "AA name: "
		     aa-location-alist
		     nil nil nil gikope-aa-history))))
;; parse
(defun gikope-parse-aa ()
  "AA $B%G!<%?$rFI$_$3$_!"(Bparse AA data and build gikope-aa-location-alist"
  (interactive)
  (let (alistitem
	locitem
	mojiname
	start
	end)
    (save-excursion
      (set-buffer (get-buffer-create gikope-aa-buffer))
      (erase-buffer)
      (let ((coding-system-for-read gikope-aa-file-coding))
	(insert-file-contents gikope-aa-file))
      (goto-char (point-min))
      (setq buffer-read-only t)
      (while (re-search-forward gikope-aa-begin-regex nil t)
	(setq alistitem (match-string 1))
	(forward-line)
	(setq locitem (point))
	(re-search-forward gikope-aa-end-regex)
	(beginning-of-line)
	(setq locitem (cons locitem (point)))
	(setq alistitem (cons alistitem (list locitem)))
	(setq gikope-aa-location-alist 
	      (cons alistitem gikope-aa-location-alist))))))

;;
(defun gikope (&optional arg)
  "$B%.%3%Z(B $B<jH4$-(B UI $B%b!<%I(B"
  (interactive "P")
  (unless gikope-aa-location-alist
    (gikope-parse-aa))
  (let ((aa-alist (if arg (gikope-get-matched-aa-alist (read-string "Regex: "))
		    gikope-aa-location-alist)))
    (setq gikope-window-configuration (current-window-configuration))
    (delete-other-windows)
    (switch-to-buffer gikope-list-buffer-name)
    (gikope-list aa-alist)))

(defun gikope-exit ()
  "$B%.%3%Z%b!<%I$r=*N;$9$k(B"
  (interactive)
  (set-window-configuration gikope-window-configuration))

;; internal functions
(defun gikope-get-aa (name)
  "NAME $B$+$i(B AA $B$r<hF@$9$k(B"
  (with-current-buffer gikope-aa-buffer
    (let ((location (cadr (assoc name gikope-aa-location-alist))))
      (buffer-substring (car location) (cdr location))))  )

(defun gikope-copy-aa (name)
  "NAME $B$N(B AA $B$r(B kill-ring $B$K%3%T!<$9$k(B"
  (kill-new (gikope-get-aa name)))
  
(defun gikope-get-matched-aa-alist (re)
  "gikope-aa-location-alist $B$+$i@55,I=8=$K%^%C%A$7$?$b$N$N$_$r<hF@(B"
  (let
      ((temp-alist gikope-aa-location-alist)
       (ret-alist '())
       temp-car)
    (while (not (eq temp-alist nil))
      (setq temp-car (car temp-alist))
      (setq temp-alist (cdr temp-alist))
      (if (string-match re (car temp-car))
	  (setq ret-alist (cons temp-car ret-alist))))
    ret-alist))


;;; Gikope-list Functions
;; gikope-list entry point
(defun gikope-list (aa-alist)
  "AA $B$NL>A00lMw$rI=<($9$k(B"
  (interactive)
  (gikope-list-mode)
  (let ((buffer-read-only nil))
    (erase-buffer)
    (dolist (name aa-alist)
      (insert (car name) "\n")))
  (goto-char (point-min))
  (set-buffer-modified-p nil))

(defun gikope-list-mode ()
  "\\{gikope-list-mode-map}"
  (interactive)
  (kill-all-local-variables)
  (use-local-map gikope-list-mode-map)
  (setq mode-name "Gikope List")
  (setq major-mode 'gikope-list-mode)
  (setq buffer-read-only t)
  (run-hooks 'gikope-list-mode-hook))

;; gikope-list commands
(defun gikope-list-select ()
  "$B8=:_9T$N(B AA $B$rA*Br$9$k(B"
  (interactive)
  (let ((name (gikope-list-current-name)))
    (unless (get-buffer-window gikope-view-buffer-name)
      (split-window-horizontally gikope-list-window-width)
      (display-buffer (get-buffer-create gikope-view-buffer-name)))
    (gikope-view name)))

(defun gikope-list-copy ()
  "$B8=:_9T$N(B AA $B$r(B kill-ring $B$K%3%T!<$9$k(B"
  (interactive)
  (gikope-list-select)
  (gikope-view-copy))

;; gikope-list internal functions
(defun gikope-list-current-name ()
  "$B8=:_9T$NL>A0$r<hF@$9$k(B"
  (buffer-substring (save-excursion (beginning-of-line)
				    (point))
		    (save-excursion (end-of-line)
				    (point))))

;;; Gikope-view Functions
;; gikope-view entry point
(defun gikope-view (name)
  "NAME $B$G;XDj$5$l$k(B AA $B$rI=<($9$k(B"
  (interactive)
  (set-buffer gikope-view-buffer-name)
  (gikope-view-mode)
  (setq gikope-view-aa-name name)
  (let ((buffer-read-only nil))
    (erase-buffer)
    (insert (gikope-get-aa name)))
  (goto-char (point-min))
  (set-buffer-modified-p nil))
  
(defun gikope-view-mode ()
  "\\{gikope-view-mode-map}"
  (interactive)
  (kill-all-local-variables)
  (use-local-map gikope-view-mode-map)
  (setq mode-name "Gikope View")
  (setq major-mode 'gikope-view-mode)
  (setq buffer-read-only t)
  (run-hooks 'gikope-view-mode-hook))

;; gikope-view commands
(defun gikope-view-copy ()
  "$B8=:_I=<($7$F$$$k(B AA $B$r(B kill-ring $B$K%3%T!<$9$k(B"
  (interactive)
  (gikope-copy-aa gikope-view-aa-name))

(provide 'gikope)

;;

;;; dabbrev-expand-multiple.el --- dabbrev-expand for multiple

;; Copyright (C) 2007  khiker

;; Author: khiker <khiker+elisp@gmail.com>
;;         plus   <MLB33828@nifty.com>

;; Keywords: dabbrev

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
;; the Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.

;;; Commentary:

;; $BJ#?t8uJd$rA*Br$G$-$kF0E*N,8lE83+(B
;; $B$3$N%Q%C%1!<%8$O(B, Emacs 22 $B$G%F%9%H$5$l$F$$$^$9(B.

;; Dynamic abbrev for multiple selection.
;; This package tested on Emacs 22.

;;; Installation:

;; $B$3$N%U%!%$%k$r%m!<%I%Q%9$NDL$C$?=j$XCV$-(B,
;; $B0J2<$NJ8$r(B .emacs $B$KDI2C$7$^$9(B.
;;
;;   (require 'dabbrev-expand-multiple)
;;   (global-set-key "\M-/" 'dabbrev-expand-multiple)
;;
;; $B%-!<@_Dj$O(B, $B<+J,$N9%$_$K9g$o$;$F2<$5$$(B.

;; Put this file into your load-path, and,
;; add following line to .emacs.
;;
;;   (require 'dabbrev-expand-multiple)
;;   (global-set-key "\M-/" 'dabbrev-expand-multiple)
;;
;; Please match key setting to your favor.

;;; Usage:

;; dabbrev-expand-multiple $B$O(B, $B0J2<$N$h$&$K?6$kIq$$$^$9(B.
;;
;; (1) $B:G=i$K(B, dabbrev-expand-multiple $B$r5/F0$7$^$9(B.
;;     $B$9$k$H(B, $BDL>o$N(B dabbrev-expand $B$HF1MM$K?6$kIq$$$^$9(B.
;; (2) $B<!$K(B, dabbrev-expand $B$r5/F0$7$?%-!<$r2!$9$H(B,
;;     $BJ#?t8uJd$rA*Br$9$k%a%K%e!<$,8=$l$^$9(B.
;; (*) $B0lEY$KI=<($9$kN,8l$O(B, $B%G%U%)%k%H$G(B3$B$D$G$9(B.
;; (*) dabbrev-expand-multiple $B$r5/F0$7$?%-!<(B, M-/, $B$b$7$/$O(B,
;;     SPC $B$r2!$9$H(B, $B<!$N(B3$B$D$rI=<($7$^$9(B.
;; (*) x $B$b$7$/$O(B, Backspace $B$r2!$9$HA0$N(B3$B$D$KLa$j$^$9(B.

;; dabbrev-expand-multiple behaves as follows.
;;
;; (1) first, execute dabbrev-expand-multiple.
;;     and, this function behaves as well as normal dabbrev-expand.
;; (2) next, pushing the key that  starts dabbrev-expand,
;;     and, multiple option selection menu appears.
;; (*) The abbrev displayed at a time is three in default.
;; (*) pushing the key that starts dabbrev-expand-multiple, M-/, or,
;;     SPC, display next three.
;; (*) pushing x or Backspace, display previous three.

;;; Config example:

;; ;; setting abbrev displayed at a time to five.
;; (setq dabbrev-expand-multiple-select-keys '("a" "s" "d" "f" "g"))
;;
;; ;; The seconds in which tooltip is displayed.
;; (setq dabbrev-expand-multiple-tooltip-timeout 2000)
;; ;; setting to disappear at ten seconds.
;; (setq dabbrev-expand-multiple-tooltip-timeout 10)
;;
;; ;; config tooltip face.  reference : M-x list-colors-display
;; (setq dabbrev-expand-multiple-tooltip-params
;;       '((foreground-color . "grey75")
;;         (background-color . "navy blue")
;;         (border-color . "black")))
;;
;; ;; put highlight to first expanded string.
;; (setq dabbrev-expand-multiple-highlight-face 'highlight)
;;
;; ;; Face used when inline display.
;; (setq dabbrev-expand-multiple-inline-show-face 'underline)
;; ;; Change inline display face. (not use underline.)
;; (setq dabbrev-expand-multiple-inline-show-face nil)
;;
;; ;; use tooltip.
;; (setq dabbrev-expand-multiple-use-tooltip t)
;; ;; use inline display. (not use tooltip.)
;; (setq dabbrev-expand-multiple-use-tooltip nil)

;;; Note:

;; $B<!$N4X?t$O(B, SKK $B$N4X?t$r85$K2~B$$5$;$F$b$i$$$^$7$?(B.
;;
;; dabbrev-expand-multiple-in-minibuffer-p
;; dabbrev-expand-multiple-show-tooltip
;; dabbrev-expand-multiple-mouse-position
;; dabbrev-expand-multiple-inline-show
;; dabbrev-expand-multiple-inline-hide
;;
;; SKK $B$O(B, SKK Development Team $B$5$s$K(B Copyright $B$,$"$j$^$9(B.
;;
;; $B$^$?(B, dabbrev-expand-multiple $B$X$N%"%I%P%$%9$O(B,
;; dabbrev-ja.el $B$r85$K2~B$$5$;$F$b$i$$$^$7$?(B.
;; dabbrev-ja.el $B$O(B, TSUCHIYA Masatoshi $B$5$s$K(B Copyright $B$,$"$j$^$9(B.

;; following functions was remodeled by based on functions of SKK.
;;
;; dabbrev-expand-multiple-in-minibuffer-p
;; dabbrev-expand-multiple-show-tooltip
;; dabbrev-expand-multiple-mouse-position
;; dabbrev-expand-multiple-inline-show
;; dabbrev-expand-multiple-inline-hide
;;
;; SKK has Copyright to SKK  Development Team.
;;
;; and, advice to dabbrev-expand-multiple was remodeled by
;; based on dabbrev-ja.el.
;; dabbrev-ja.el has Copyright to Mr. TSUCHIYA Masatoshi.

;;; Code:

(require 'dabbrev)

(defconst dabbrev-expand-multiple-version "1.1.0"
  "dabbrev-expand-multiple $B$N%P!<%8%g%s(B

dabbrev-expand-multiple's version")

(defgroup dabbrev-expand-multiple nil
  "dabbrev-expand for multiple"
  :tag "dabbrev-expand for multiple"
  :group 'dabbrev-expand-multiple)

(defcustom dabbrev-expand-multiple-select-keys
  ;; '("" "" "" "" "")
  ;; $B%-!<$rA}$d$7$F$$$/$H(B C-g $B$KEv$?$C$?$?$a%3%s%H%m!<%kJ8;z$OHr$1$k(B
  '("a" "s" "d")
;;  '("a" "s" "d" "f" "g")
  "*$B8uJd$rA*Br$9$k$?$a$K;HMQ$9$k%-!<@_Dj(B.

Key config for selecting options."
  :type  '(repeat string)
  :group 'dabbrev-expand-multiple)

(defcustom dabbrev-expand-multiple-multi-selection-keys '("\M-/")
  "*$BJ#?t8uJdI=<($X0\$k$?$a$N%-!<@_Dj(B

Key config for moving to multiple option displaying menu."
  :type  '(repeat string)
  :group 'dabbrev-expand-multiple)

(defcustom dabbrev-expand-multiple-next-keys '("\M-/" " ")
  "*$B<!$NJd40%j%9%H$N9`L\$X0\$k$?$a$N%-!<@_Dj(B

Key config for moving to next complementarity list."
  :type  '(repeat string)
  :group 'dabbrev-expand-multiple)

(defcustom dabbrev-expand-multiple-previous-keys '("x" "\177")
  "*$BA0$NJd40%j%9%H$N9`L\$X0\$k$?$a$N%-!<@_Dj(B

Key config for moving to previous complementarity list."
  :type  '(repeat string)
  :group 'dabbrev-expand-multiple)

(defcustom dabbrev-expand-multiple-tooltip-timeout 2000
  "*$B%D!<%k%A%C%W$rI=<($9$kIC?t(B.

Seconds for displaying tooltip."
  :type  'number
  :group 'dabbrev-expand-multiple)

(defcustom dabbrev-expand-multiple-tooltip-params nil
  "*$B%D!<%k%A%C%W$N8+$?L\$N@_Dj(B.

Face config for tooltip."
  :type 'boolean
  :group 'dabbrev-expand-multiple)

(defcustom dabbrev-expand-multiple-highlight-face 'highlight
  "*$B:G=i$NJ8;zNs$rE83+$7$?$H$-$K$+$1$k8+$?L\$NJQ99(B.

Face to highlight frist time expanded string."
  :type 'face
  :group 'dabbrev-expand-multiple)

(defcustom dabbrev-expand-multiple-inline-show-face 'underline
  "*$B%$%s%i%$%s$G8uJd$rI=<($9$k:]$N%U%'%$%9$r;XDj$9$kJQ?t!#(B
$B8uJdJ8;zNs$N%U%'%$%9B0@-$r$=$N$^$^;H$$$?$$>l9g$O(B nil $B$K@_Dj$9$k!#(B
SKK $B$N(B skk-inline-show-face $B$h$j(B.

A Variable to appoint a face when display a option in inline.
By skk-inline-show-face of SKK."
  :type '(radio (face  :tag "$B%U%'%$%9$r;XDj(B")
                (const :tag "$B8uJdJ8;zNs$N%U%'%$%9B0@-$r$=$N$^$^;HMQ(B"))
  :group 'dabbrev-expand-multiple)

(defcustom dabbrev-expand-multiple-use-tooltip t
  "*$B%D!<%k%A%C%W$r;H$C$FI=<($9$k$+$I$&$+(B.

Non-nil means to use tooltip."
  :type 'boolean
  :group 'dabbrev-expand-multiple)

(defvar dabbrev-expand-multiple-inline-overlay nil)
(defvar dabbrev-expand-multiple-last-key nil)

(defun dabbrev-expand-multiple ()
  "$BJd408uJd$rJ#?t7G<($9$kF0E*N,8lE83+$r9T$&4X?t(B.

$B4X?t$r<B9T$9$k$H(B, $BDL>o$N(B dabbrev-expand $B$HF1MM$K(B, 1$B$D$N8uJd$N$_$,Jd40$5$l$k(B.
$B$=$NJd40$,<+J,$N5a$a$k$b$N$G$J$+$C$?>l9g(B,
dabbrev-expand-multiple $B$r5/F0$7$?%-!<(B, $B$b$7$/$O(B,
M-/ $B$r$b$&0lEY2!$9$3$H$G(B, $BJ#?t$NJd408uJd$N7G<($,9T$o$l$k(B.

$B%G%U%)%k%H$G7G<($5$l$kJd408uJd$N?t$O(B, 3$B$D$G$"$k(B.
$B$3$N?t$O(B, dabbrev-expand-multiple-select-keys $B$K$h$j(B, $B@)8f$5$l$k(B.
$B$3$NJQ?tFb$NJd408uJd$NA*Br$K;HMQ$9$k%-!<$rA}$d$9$3$H$G(B,
$B0lEY$KI=<($5$l$kJd408uJd$N?t$b(B, $B$=$l$K1~$8$FA}2C$9$k(B.

$BJd408uJd$NI=<($O(B, $B%_%K%P%C%U%!(B, $B%$%s%i%$%s(B, tooltip $B$N(B3$B<oN`$,MQ0U$5$l$F$$$k(B.
$BJQ?t(B dabbrev-expand-multiple-use-tooltip $B$r(B t $B$H$9$k$H(B
$B%D!<%k%A%C%W$G$NI=<($r9T$&(B.
nil $B$J$i$P(B, $B%$%s%i%$%s$G$NI=<($r9T$&(B.
nil $B$G$+$D(B, $B%]%$%s%H$,%_%K%P%C%U%!$K$"$C$?>l9g$O(B, $B%_%K%P%C%U%!$G$NI=<($r9T$&(B.

The function that do dynamic abbrev expansion for multiple selection."
  (interactive)
  ;; reset dabbrev's global variables
  (dabbrev--reset-global-variables)
  (let* ((target (dabbrev--abbrev-at-point))
         (abbrev (dabbrev--find-expansion target 0 dabbrev-case-fold-search))
         (prompt "")
         action overlay)
    (cond
     ;; Dynamic expansion found.
     (abbrev
      ;; insert abbrev
      (insert (substring abbrev (length target)))
      ;; hightlight abbrev
      (setq overlay (make-overlay (- (point) (length abbrev)) (point)))
      (overlay-put overlay 'face dabbrev-expand-multiple-highlight-face)
      ;; wait key input. and, record pushed key.
      (setq action (read-key-sequence-vector prompt))
      ;; reset hightlight
      (delete-overlay overlay)
      ;; record last-command-char
      (setq dabbrev-expand-multiple-last-key last-command-char)
      (cond
       ((dabbrev-expand-multiple-selection-keys-p
         action dabbrev-expand-multiple-multi-selection-keys t)
        ;; reset abbrev
        (delete-char (- (length abbrev)))
        (insert target)
        ;; start dabbrev-expand-multiple
        (dabbrev-expand-multiple-main 1 (list (list abbrev))))
       ;; execute command that bound to pushed key.
       (t
        (dabbrev-expand-multiple-do-last-command action))))
     ;; Dynamic expansion *Not* found.
     (t
      (message "No dynamic expansion for `%s' found" target)))))

(defun dabbrev-expand-multiple-main (num alist)
  "$BJd408uJd$rJ#?t7G<($9$kF0E*N,8lE83+$N%a%$%sItJ,$rC4$&4X?t(B.

The function that do main part of dynamic abbrev expansion for
multiple selection."
  ;; setting local variable
  (let* ((target (dabbrev--abbrev-at-point))
         (keys (reverse dabbrev-expand-multiple-select-keys))
         i prompt abbrev-list sel abbrev action)
    (while (> num -1)
      ;; initialize local variables
      (setq i (length keys)
            prompt ""
            abbrev-list (nth num alist)
            sel (null abbrev-list)
            abbrev nil
            action nil)
      ;; setting abbrev for display
      (while (and (> i 0)
                  (setq abbrev
                        (if sel
                            ;; get new abbrev
                            (dabbrev--find-expansion
                             target 0 dabbrev-case-fold-search)
                          ;; next abbrev has been already gotten.
                          (nth (- (length keys) i) abbrev-list))))
        (add-to-list 'abbrev-list abbrev t)
        (setq prompt (format "%s(%s): %s%s" prompt (nth (1- i) keys) abbrev
                             (if dabbrev-expand-multiple-use-tooltip "\n" " ")))
        (setq i (1- i)))
      ;; couldn't get new abbrev.
      (when (null abbrev-list)
        (setq prompt "No dynamic expansion"))
      ;; create tooltip, overlay or minibuffer message.
      (cond
       ;; point in minibuffer
       ((dabbrev-expand-multiple-in-minibuffer-p)
        (setq action (read-key-sequence-vector prompt)))
       ;; use tooltip
       (dabbrev-expand-multiple-use-tooltip
        (let* ((P (dabbrev-expand-multiple-mouse-position))
               (frame (car P))
               (x (cadr P))
               (y (cddr P))
               (oP (mouse-position))
               (oframe (car oP))
               ;; $B%^%&%9%+!<%=%k$,%U%l!<%`>e$K$J$$$H(B,
               ;; $B85$N%^%&%90LCV$,<hF@$G$-$:(B, $B%(%i!<$,=P$k$N$G(B, $B$=$NBP:v(B.
               (ox (or (cadr oP) 0))
               (oy (or (cddr oP) 15)))
          ;; move mouse position.
          (set-mouse-position frame x y)
          (dabbrev-expand-multiple-show-tooltip prompt)
          (setq action (read-key-sequence-vector ""))
          (tooltip-hide)
          (set-mouse-position oframe ox oy)))
       ;; use inline show
       (t
        (dabbrev-expand-multiple-inline-show
         prompt dabbrev-expand-multiple-inline-show-face)
        (setq action (read-key-sequence-vector ""))
        (dabbrev-expand-multiple-inline-hide)))
      ;; clear minibuffer
      (message "")
      (setq sel (length (member (string (aref action 0)) keys)))
      (add-to-list 'alist abbrev-list t)
      (cond
       ;; next selection
       ((dabbrev-expand-multiple-selection-keys-p
         action dabbrev-expand-multiple-next-keys t)
        (when abbrev-list (setq num (1+ num))))
       ;; previous selection
       ((dabbrev-expand-multiple-selection-keys-p
         action dabbrev-expand-multiple-previous-keys)
        (when (> num 0) (setq num (1- num))))
       ;; exit while loop
       (t (setq num -1))))
    (cond
     ;; dabbrev-expand-multiple-select-keys $B0J30$N%-!<$,2!$5$l$?(B
     ((or (= sel 0) (> sel (length abbrev-list)))
      (dabbrev-expand-multiple-do-last-command action))
     (t
      ;; insert selected string
      (insert
       (substring (nth (1- sel) abbrev-list) (length target)))))))

(defun dabbrev-expand-multiple-selection-keys-p (action keys &optional last)
  "dabbrev-expand-multiple $B$r5/F0$9$k$?$a$K;HMQ$7$?%-!<$HF1$8%-!<(B,
$B$b$7$/$O(B keys $B$N$&$A$I$l$+$,2!$5$l$?$+$I$&$+$r%A%'%C%/$9$k(B"
  (not (not (memq (aref action 0)
                  (apply 'append
                         (when last
                           (list dabbrev-expand-multiple-last-key))
                         (mapcar
                          (lambda (x)
                            (cond
                             ((stringp x)
                              (listify-key-sequence x))
                             ((numberp x)
                              (list x))
                             ((listp x)
                              (list (event-convert-list x)))
                             ((vectorp x)
                              (list (event-convert-list (aref x 0))))))
                          keys))))))

(defun dabbrev-expand-multiple-do-last-command (action)
  "$BF~NO$7$?%-!<$K3d$jEv$F$i$l$F$$$k%3%^%s%I$r<B9T$9$k(B"
  (let ((last-command-char (aref action 0))
        (command (key-binding action)))
    (when command
      (call-interactively command))
    (message "")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; SKK $B$h$jGR<Z$7$?4X?t72(B
;;; ------------------------------------------------------------
;; $B4X?tL>$r(B dabbrev-expand-multiple $B$K9g$o$;$FJQ99$7$F$$$k$N$_$G(B,
;; $BFbMF$O(B, $B$[$\$=$N$^$^$G$9(B.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun dabbrev-expand-multiple-in-minibuffer-p ()
  "$B%+%l%s%H%P%C%U%!$,%_%K%P%C%U%!$+$I$&$+$r%A%'%C%/$9$k!#(B
SKK $B$N(B skk-in-minibuffer-p $B$r$=$N$^$^GR<Z$5$;$FD:$-$^$7$?(B."
  (eq (current-buffer) (window-buffer (minibuffer-window))))

(defun dabbrev-expand-multiple-show-tooltip (text)
  "$B%D!<%k%A%C%W$rI=<($9$k4X?t(B.
$B%D!<%k%A%C%W$rE,@Z$J0LCV$KI=<($9$k$?$a$K(B, $B%^%&%9%+!<%=%k$N0\F0$r9T$C$F$$$k(B.
$B$3$l$O(B, $B%D!<%k%A%C%W$O(B, $B%^%&%9%+!<%=%k$N$"$k>l=jIU6a$KI=<($5$l$k$?$a(B.
$B%D!<%k%A%C%W$rI=<($7$?8e(B, $B%^%&%9%+!<%=%k$O85$N>l=j$KLa$k(B.
$B$[$\(B SKK $B$N(B skk-tooltip-show-1 $B$N%3%T!<(B.
$BJQ?t@_Dj$r(B dabbrev-expand-multiple-tooltip-params $B$K$7$?$N$_(B."
  (condition-case error
      (let ((params (copy-sequence tooltip-frame-parameters))
            fg bg)
        (if dabbrev-expand-multiple-tooltip-params
            ;; $B%f!<%6$,FH<+$K(B tooltip $BI=<(@_Dj$9$k(B
            (dolist (cell dabbrev-expand-multiple-tooltip-params)
              (setq params (tooltip-set-param params
                                              (car cell)
                                              (cdr cell))))
          ;; tooltip $B$N%G%U%)%k%H$N@_Dj$r$9$k(B
          (setq fg (face-attribute 'tooltip :foreground))
          (setq bg (face-attribute 'tooltip :background))
          (when (stringp fg)
            (setq params (tooltip-set-param params 'foreground-color fg))
            (setq params (tooltip-set-param params 'border-color fg)))
          (when (stringp bg)
            (setq params (tooltip-set-param params 'background-color bg))))
        (x-show-tip (propertize text 'face 'tooltip)
                    (selected-frame)
                    params
                    dabbrev-expand-multiple-tooltip-timeout
                    tooltip-x-offset
                    tooltip-y-offset))
    (error
     (message "Error while displaying tooltip: %s" error)
     (sit-for 1)
     (message "%s" text))))

(defun dabbrev-expand-multiple-mouse-position ()
  "Return the position of point as (FRAME X . Y).
Analogous to mouse-position.

SKK $B$N(B skk-e21-mouse-position $B$r$[$\N.MQ(B.
$B%_%K%P%C%U%!$r?6$jJ,$1$F$$$?$N$r>C$7(B, $B%3%a%s%H$r:o=|$7$F$7$^$C$?$0$i$$(B."
  (let* ((w (selected-window))
         (edges (window-edges w))
         (list
          (compute-motion
           (max (window-start w) (point-min))
           '(0 . 0)
           (point)
           (cons (window-width w) (window-height w))
           (1- (window-width w))
           (cons (window-hscroll w) 0)
           w)))
    (cons (selected-frame)
          (cons (+ (car edges)       (car (cdr list)))
                (+ (car (cdr edges)) (car (cdr (cdr list))))))))

(defun dabbrev-expand-multiple-inline-show (string face)
  "overlay $B$r;HMQ$7$F(B, $BJ8;zNs$r%$%s%i%$%sI=<($9$k4X?t(B.
SKK $B$N(B skk-inline-show $B$h$jL>A0$rJQ99$7$FGR<Z$5$;$FD:$-$^$7$?(B."
  (dabbrev-expand-multiple-inline-hide)
  (unless (dabbrev-expand-multiple-in-minibuffer-p)
    (setq dabbrev-expand-multiple-inline-overlay
          (make-overlay (point) (point)))
    (overlay-put dabbrev-expand-multiple-inline-overlay
                 'after-string
                 (apply #'propertize string
                        (if face `(face ,face) nil)))))

(defun dabbrev-expand-multiple-inline-hide ()
  "dabbrev-expand-multiple-inline-show $B$G$N%*!<%P%l%$$r:o=|$9$k4X?t(B.
SKK $B$N(B skk-inline-hide $B$h$jL>A0$rJQ99$7$FGR<Z$5$;$FD:$-$^$7$?(B."
  (when dabbrev-expand-multiple-inline-overlay
    (delete-overlay dabbrev-expand-multiple-inline-overlay)
    (setq dabbrev-expand-multiple-inline-overlay nil)))

;; $BF|K\8l$NC18l$KBP1~$9$k$h$&$K$9$k@_Dj(B
;; from http://namazu.org/~tsuchiya/elisp/dabbrev-ja.el
;; dabbrev-expand $B$KBP$9$k%"%I%P%$%9$r(B dabbrev-expand-multiple
;; $B$KJQ99$7$?$N$_$G$=$N$^$^;}$C$F$3$5$;$FD:$-$^$7$?(B.
(or (boundp 'MULE)                      ; Mule2 $B$H(B
    (featurep 'xemacs)                  ; XEmacs $B$O@_DjITMW(B
    (let (current-load-list)
      (defadvice dabbrev-expand-multiple
        (around modify-regexp-for-japanese activate compile)
        "Modify `dabbrev-abbrev-char-regexp' dynamically for Japanese words."
        (if (bobp)
            ad-do-it
          (let ((dabbrev-abbrev-char-regexp
                 (let ((c (char-category-set (char-before))))
                   (cond
                    ((aref c ?a) "[-_A-Za-z0-9]") ; ASCII
                    ((aref c ?j)                  ; Japanese
                     (cond
                      ((aref c ?K) "\\cK") ; katakana
                      ((aref c ?A) "\\cA") ; 2byte alphanumeric
                      ((aref c ?H) "\\cH") ; hiragana
                      ((aref c ?C) "\\cC") ; kanji
                      (t "\\cj")))
                    ((aref c ?k) "\\ck") ; hankaku-kana
                    ((aref c ?r) "\\cr") ; Japanese roman ?
                    (t dabbrev-abbrev-char-regexp)))))
            ad-do-it)))))

(provide 'dabbrev-expand-multiple)
;; dabbrev-expand-multiple.el ends here

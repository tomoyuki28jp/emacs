;;; navi2ch-logo.el --- Inline logo module for navi2ch

;; Copyright (C) 2002 by navi2ch Project

;; Author:
;;   (not 1)
;;   http://pc.2ch.net/test/read.cgi/unix/999166513/895 $B$NL>L5$7$5$s(B
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
;; $B%l%90lMw$N@hF,$K$=$NHD$N%m%4$rE=$j$D$1$k!#(B
;;
;; Emacs 21 $B$J$i(B navi2ch-logo.elc? $B$K(B load-path $B$rDL$7$F$3$&$7$k!*(B
;;
;; (require 'navi2ch-logo)
;; (add-hook 'navi2ch-hook 'navi2ch-logo-init)
;;
;; $B$$$^$N$H$3$m30It%W%m%0%i%`(B `gifsicle' $B$H(B `convert' $B$,I,?\!#(B
;;
;; gifsicle $B$O%"%K%a!<%7%g%s(B GIF $B$NHs%"%K%a!<%7%g%s2=$K;H$&!#(B
;; convert $B$O3F<o2hA|%U%)!<%^%C%H$rLdEzL5MQ$K(B XPM $B$K%3%s%P!<%H(B
;; $B$9$k$?$a$K;H$C$F$k!#%O!<%I%3!<%I$7$F$$$k$N$OD>$5$J$/$A$c!#(B
;;
;; $BHD0lMw$NFI$_9~$_$O!"%m%4$r;}$C$F$/$k$V$sEvA3CY$/$J$k!#(B
;; $B%U%!%$%k<hF@$O(B wget $B$H$+$KG$$;$FHsF14|2=$9$l$P$$$$$N$+$b!#(B
;;

;;; Code:
(provide 'navi2ch-logo)

(eval-when-compile (require 'cl))

(require 'navi2ch-board)
(require 'navi2ch-board-misc)
(require 'navi2ch-net)

(defvar navi2ch-logo-temp-directory nil
  "$B%3%s%P!<%H$7$?2hA|%U%!%$%k$rF~$l$k%F%s%]%i%j%G%#%l%/%H%j!#(B")
(defvar navi2ch-logo-temp-directory-prefix ".navi2ch-logo-"
  "$B%F%s%]%i%j%F%#%l%/%H%j$N%5%U%#%C%/%9!#$3$l$K%i%s%@%`$JJ8;zNs$r(B
$BB-$7$?$b$N$,%G%#%l%/%H%jL>$K$J$k(B")
(defvar navi2ch-logo-temp-name-prefix "img-"
  "$B%F%s%]%i%j%U%!%$%k$N%5%U%#%C%/%9!#(B")
(defvar navi2ch-logo-image-alist nil
  "\`($BHD$N(Bid  $B$=$NHD$N%m%4$N(Bimage)\' $B$+$i$J$k(B alist$B!#(B
$B$$$A$I(B create-image $B$7$?2hA|$O$3$3$KDI2C$7$F:FMxMQ$9$k!#(B")
(defvar navi2ch-logo-previous-image nil)

(defun navi2ch-logo-init ()
  "navi2ch-logo $B$r=i4|2=$7$F;H$($k$h$&$K$9$k!#(B"
  (when (and navi2ch-on-emacs21 (not navi2ch-logo-temp-directory))
    (setq navi2ch-logo-temp-directory
          (file-name-as-directory
           (make-temp-file navi2ch-logo-temp-directory-prefix t)))
    (add-hook 'navi2ch-exit-hook 'navi2ch-logo-cleanup)
    (add-hook 'navi2ch-bm-select-board-hook 'navi2ch-logo-update)
    (add-hook 'navi2ch-board-after-sync-hook 'navi2ch-logo-update)))

(defun navi2ch-logo-cleanup ()
  "$B%F%s%]%i%j%U%!%$%k$N8e;OKv$J$I$r$7$F!"JQ?t$r=i4|CM$KLa$9!#(B"
  (when (and navi2ch-logo-temp-directory
             (file-directory-p navi2ch-logo-temp-directory))
    (dolist (file (directory-files navi2ch-logo-temp-directory t))
      (and (file-regular-p file)
           (delete-file file)))
    (delete-directory navi2ch-logo-temp-directory))
  (setq navi2ch-logo-temp-directory nil
        navi2ch-logo-image-alist nil))

(defun navi2ch-logo-update ()
  "`navi2ch-board-mode' $B$GF0:n$7!"%m%4$rFI$_9~$s$G%P%C%U%!>eIt$KE=$jIU$1$k!#(B
`navi2ch-board-select-board-hook' $B$+$i8F$P$l$k!#(B"
  (if (eq major-mode 'navi2ch-board-mode)
      (let* ((id (cdr (assq 'id navi2ch-board-current-board)))
             (image (cdr (assoc id navi2ch-logo-image-alist))))
        (if (eq image t)
            (navi2ch-logo-remove-image (point-min))
          (when (and (not image) (not navi2ch-offline))
            (condition-case err
                (catch 'quit
                  (setq image (navi2ch-logo-create-logo-image)))
              (t nil))
            (setq navi2ch-logo-image-alist
                  (navi2ch-put-alist id (or image t) navi2ch-logo-image-alist)))
          (when (and image (not (eq image navi2ch-logo-previous-image)))
            (navi2ch-logo-remove-image (point-min))
            (navi2ch-logo-put-image (point-min) image)
            (setq navi2ch-logo-previous-image image))))
    (navi2ch-logo-remove-image (point-min))))

(defun navi2ch-logo-put-image (point image)
  "POINT $B0LCV$K(B IMAGE $B$rE=$jIU$1$k!#(B

IMAGE $B$rD>@\%P%C%U%!%F%-%9%H$N(B display property $B$K$9$k$N$O%^%:$$!#(B
$B$J$<$J$i$3$N2hA|$OJ8;z$H$OFHN)$7$?$b$N$@$+$i!#(B

$B$=$3$G!"(B
 (1) $B$^$:(B POINT $B0LCV$KD9$5(B 0 $B$N%*!<%P!<%l%$$r:n$k(B
 (2) $BE,Ev$JJ8;zNs$N(B text property ($B$N(B `display' property) $B$K(B IMAGE $B$r(B
     $B;XDj$7$F!"%F%-%9%H$H$7$F07$($k$h$&$K$9$k(B
 (3) (1) $B$G:n$C$?%*!<%P!<%l%$$N(B `before-string' $BB0@-$K!"(B(2) $B$NJ8;zNs$r(B
     $B;XDj$9$k(B
$B$H$$$&<j=g$rF'$s$G$$$k!#(B"
  (let ((overlay (make-overlay point point))
        (str (propertize (concat (propertize " " 'display image)
                                 "\n")
                         'face 'default)))
    ;; $B2hA|$N>e$X$N%]%$%s%H0\F0$r6X;_!#(B
    (overlay-put overlay 'intangible t)

    ;; `face' $B$K(B `default' $B$r;XDj$7$F!"6a$/$NJ8;z$N%F%-%9%H(B
    ;; $B%W%m%Q%F%#$N(B underline $B$d(B stroke $B$N1F6A$rGS=|!#(B
    (overlay-put overlay 'face 'default)  

    ;; navi2ch-logo $B$,:n$C$?$H$$$&$3$H$,$o$+$k$h$&$K!#(B
    (overlay-put overlay 'navi2ch-logo t) 

    (overlay-put overlay 'before-string str)))

(defun navi2ch-logo-remove-image (&optional point)
  "`navi2ch-logo-put-image' $B$,CV$$$?2hA|$r(B POINT $B0LCV$+$i>C$9!#(B
$B>C$9$Y$-2hA|$,$J$1$l$P2?$b$7$J$$!#(B"
  (unless point
    (setq point (point-min)))
  (let ((ls (overlays-in point point))
        overlay)
    (while (and ls (not overlay))
      (when (overlay-get (car ls) 'navi2ch-logo)
        (setq overlay (car ls)))
      (setq ls (cdr ls)))
    (when overlay
      (delete-overlay overlay))))

(defun navi2ch-logo-create-logo-image ()
  "$B%m%4$r%@%&%s%m!<%I$7$F(B `create-image' $B$7$?7k2L$rJV$9!#(B

$B30It%W%m%0%i%`(B \`gifsicle\' $B$O%"%K%a!<%7%g%s(B GIF $B$rHs%"%K%a2=(B
$B$9$k$?$a$K;H$&!#(B\`convert\' $B$O2hA|$r0lN'$K(B XPM $B$KJQ49$9$k$?$a$K;H$C$F$k!#(B

Emacs $B$O(B XPM $B0J30$b$b$A$m$s%5%]!<%H$7$F$k$+$i!"K\Mh$OA4It(B XPM $B$K(B
$B$9$k$3$H$O$J$$!#(B`image-types' $B$r;2>H$9$k$J$j(B `create-image' $B$N(B
$BJV$jCM$r8+$k$J$j$7$F!"30It%W%m%0%i%`$N5/F0$OI,MW:G>/8B$K$H$I$a$?(B
$B$[$&$,$$$$!#(B"
  (let ((logo-file (navi2ch-net-download-logo navi2ch-board-current-board))
        (xpm-file (concat navi2ch-logo-temp-directory
                          (make-temp-name navi2ch-logo-temp-name-prefix)
                          ".xpm"))
        temp-file)
    (unless logo-file (throw 'quit nil))
    (when (string-match "\\.gif$" logo-file)
      (setq temp-file (concat navi2ch-logo-temp-directory
                              (make-temp-name navi2ch-logo-temp-name-prefix)
                              ".gif"))
      (when (/= 0 (call-process "gifsicle" logo-file nil nil
                                "#-1" "--output" temp-file))
        (throw 'quit nil))
      (setq logo-file temp-file))
    (when (/= 0 (call-process "convert" nil nil nil
                              "-border" "1x1"
                              "-bordercolor" "black"
                              logo-file xpm-file))
      (throw 'quit nil))
    (if temp-file (delete-file temp-file))
    (create-image xpm-file 'xpm)))

;;; navi2ch-logo.el ends here

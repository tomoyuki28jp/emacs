;;; navi2ch-vars.el --- User variables for navi2ch. -*- coding: iso-2022-7bit; -*-

;; Copyright (C) 2001, 2002, 2003, 2004, 2005, 2006, 2007, 2008 by
;; Navi2ch Project

;; Author: Taiki SUGAWARA <taiki@users.sourceforge.net>
;; Keywords: www 2ch

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
(provide 'navi2ch-vars)

(eval-when-compile
  (unless (fboundp 'coding-system-list)
    (defalias 'coding-system-list 'ignore)))

(defconst navi2ch-vars-ident
  "$Id: navi2ch-vars.el,v 1.184.2.2 2008/08/26 14:08:01 nawota Exp $")

(defconst navi2ch-on-xemacs (featurep 'xemacs))
(defconst navi2ch-on-emacs21 (and (not navi2ch-on-xemacs)
                                  (>= emacs-major-version 21)))

(defvar navi2ch-coding-system
  (or (car (memq 'cp932 (coding-system-list)))
      (car (memq 'shift_jis-2004 (coding-system-list)))
      'shift_jis))

(defgroup navi2ch nil
  "*Navigator for 2ch."
  :prefix "navi2ch-"
  :link '(url-link :tag "Navi2ch Project$B%[!<%`%Z!<%8(B" "http://navi2ch.sourceforge.net/")
  :link '(custom-manual :tag "$B%^%K%e%"%k(B (Info)" "(navi2ch)top")
  :group 'hypermedia
  :group '2ch)

(defgroup navi2ch-list nil
  "*Navi2ch, list buffer."
  :prefix "navi2ch-"
  :group 'navi2ch)

(defgroup navi2ch-board nil
  "*Navi2ch, board buffer."
  :prefix "navi2ch-"
  :group 'navi2ch)

(defgroup navi2ch-article nil
  "*Navi2ch, article buffer."
  :prefix "navi2ch-"
  :group 'navi2ch)

(defgroup navi2ch-message nil
  "*Navi2ch, message buffer."
  :prefix "navi2ch-"
  :group 'navi2ch)

(defgroup navi2ch-net nil
  "*Navi2ch, networking."
  :prefix "navi2ch-"
  :group 'navi2ch)

(defgroup navi2ch-localfile nil
  "*Navi2ch, localbbs."
  :prefix "navi2ch-"
  :group 'navi2ch)

;;; navi2ch variables
(defcustom navi2ch-ask-when-exit 'y-or-n-p
  "*non-nil $B$J$i!"(Bnavi2ch $B=*N;$N3NG'%a%C%;!<%8$rI=<($9$k!#(B"
  :type '(choice (const :tag "yes-or-no-p $B$G3NG'(B" yes-or-no-p)
                 (const :tag "y-or-n-p $B$G3NG'(B" y-or-n-p)
                 (const :tag "$BJ9$+$:$K=*N;(B" nil))
  :group 'navi2ch)

(defcustom navi2ch-directory "~/.navi2ch"
  "*$B%-%c%C%7%e%U%!%$%k$J$I$rJ]B8$9$k%G%#%l%/%H%j!#(B

$B$3$N%G%#%l%/%H%j$O!"%-%c%C%7%e$NNL$K$h$C$F(B 100MB $B0J>e$KKD$i$`(B
$B$3$H$b$"$k!#%-%c%C%7%e$N@)8B$K$D$$$F$O(B `navi2ch-board-expire-date'
$B$r;2>H!#(B"
  :type 'directory
  :group 'navi2ch)

(defcustom navi2ch-uudecode-program "uudecode"
  "*uudecode $B$9$k$N$K;H$&%W%m%0%i%`!#(B"
  :type 'string
  :group 'navi2ch)

(defcustom navi2ch-uudecode-args nil
  "*uudecode $B$r<B9T$9$k$H$-$N0z?t!#(B"
  :type '(repeat :tag "$B0z?t(B" string)
  :group 'navi2ch)

(defcustom navi2ch-bzip2-program "bzip2"
  "*bzip2 $B$K;H$&%W%m%0%i%`!#(B"
  :type 'string
  :group 'navi2ch)

(defcustom navi2ch-bzip2-args '("-d" "-c" "-q")
  "*bzip2 $B$r8F$S=P$9$H$-$N0z?t!#(B"
  :type '(repeat :tag "$B0z?t(B" string)
  :group 'navi2ch)

(defcustom navi2ch-init-file "init"
  "*navi2ch $B$N=i4|2=%U%!%$%k!#(B"
  :type 'file
  :group 'navi2ch)

(defcustom navi2ch-browse-url-browser-function nil
  "*Navi2ch $B$+$i;HMQ$9$k%V%i%&%64X?t!#(B
nil $B$N>l9g$O(B `browse-url-browser-function' $B$r;H$&!#(B
\(autoload 'navi2ch-browse-url \"navi2ch\" nil t)
\(setq navi2ch-browse-url-browser-function 'w3m-browse-url)
\(setq browse-url-browser-function 'navi2ch-browse-url)
$B$N$h$&$K@_Dj$7$F$*$/$H!"B>$N%Q%C%1!<%8$+$i(B Navi2ch $B$r8F$S=P$9;v$,$G$-$k!#(B"
  :type '(choice (const :tag "browsw-url $B$K$^$+$;$k(B" nil)
		 (function :tag "$B4X?t$r;XDj$9$k(B"))
  :group 'navi2ch)

(defcustom navi2ch-browse-url-image-program nil
  "*`navi2ch-browse-url-image' $B$K;H$&%W%m%0%i%`!#(B"
  :type '(choice string (const :tag "None" nil))
  :group 'navi2ch)

(defcustom navi2ch-browse-url-image-args nil
  "*`navi2ch-browse-url-image-program' $B$KM?$($k0z?t!#(B"
  :type '(repeat (string :tag "Argument"))
  :group 'navi2ch)

(defcustom navi2ch-browse-url-image-extentions '("jpg" "jpeg" "gif" "png")
  "*`navi2ch-browse-url-image' $B$GI=<($9$k2hA|$N3HD%;R!#(B"
  :type '(repeat (string :tag "$B3HD%;R(B"))
  :group 'navi2ch)

(defcustom navi2ch-base64-fill-column 64
  "*base64 $B$G%(%s%3!<%I$5$l$?J8;zNs$r(B fill $B$9$kJ8;z?t!#(B"
  :type 'integer
  :group 'navi2ch)

(defcustom navi2ch-2ch-host-list
  '("cocoa.2ch.net" "pc.2ch.net" "pc2.2ch.net")
  "*2$B$A$c$s$M$k$H$_$J$9(B host $B$N%j%9%H!#(B"
  :type '(repeat (string :tag "$B%[%9%H(B"))
  :group 'navi2ch)

(defcustom navi2ch-use-lock t
  "*non-nil $B$J$i!"(BNavi2ch $B$,5/F0$9$k:]$K(B `navi2ch-directory' $B$r%m%C%/$9$k!#(B"
  :type 'boolean
  :group 'navi2ch)

(defcustom navi2ch-lock-name "lockdir"
  "*$B%m%C%/%G%#%l%/%H%j$NL>A0!#(B
$B@dBP%Q%9$K$9$l$P(B `navi2ch-directory' $B0J30$N>l=j$K$b%m%C%/%G%#%l%/%H%j(B
$B$r:n$l$k$,!"AG?M$K$O$*4+$a$7$J$$!#(B"
  :type 'string
  :group 'navi2ch)

(defcustom navi2ch-file-name-reserved-char-list '(?:)
  "*navi2ch-expand-file-name $B$G%(%9%1!<%W$9$kJ8;z$N%j%9%H!#(B
$B%G%U%)%k%H$O(B '(?:) $B$G!"(BURL $BCf$N(B \":\" $B$,%G%#%l%/%H%jL>$G$O(B \"%3A\" $B$K%(%9%1!<%W$5$l$k!#(B
\"~\" $B$b%(%9%1!<%W$7$?$$$H$-$O(B '(?: ?~) $B$r;XDj$9$k!#(B"
  :type 'regexp
  :group 'navi2ch)

(defcustom navi2ch-decode-character-references t
  "*non-nil $B$J$i!"?tCMJ8;z;2>H!"J8;z<BBN;2>H$NI=<($r;n$_$k!#(B
GNU Emacs 21, XEmacs 21.5 $B0J9_$G$"$l$P%G%U%)%k%H$GI=<($G$-$^$9$,!"(B
$B$=$l0JA0$N(B Emacsen $B$G$O(B Mule-UCS $B$,I,MW$G$9!#(B(require 'un-define) $B$7$F$M!#(B"
  :type 'boolean
  :group 'navi2ch)

(defcustom navi2ch-pgp-verify-command-line nil
  "PGP $B=pL>$r8!>Z$9$k%3%^%s%I%i%$%s!#(B
$B=pL>%U%!%$%kL>!"=pL>85%U%!%$%kL>$H6&$K(B `format' $B$N0z?t$H$J$k!#(B"
  :type '(choice (const :tag "$BL58z(B" nil)
		 (const :tag "PGP" "pgp %s %s")
		 (const :tag "GPG" "gpg --verify %s %s")
		 (string :tag "$B;XDj(B"))
  :group 'navi2ch)

(defcustom navi2ch-enable-status-check nil
  "non-nil $B$J$i$P%V%i%&%6$r3+$/A0$K(B HEAD $B$G@\B3@h$r3NG'$9$k!#(B"
  :type 'boolean
  :group 'navi2ch)

;;; list variables
(defcustom navi2ch-list-window-width 20
  "*$BHD0lMw%&%#%s%I%&$N2#I}!#(B"
  :type 'integer
  :group 'navi2ch-list)

(defcustom navi2ch-list-etc-file-name "etc.txt"
  "*$B!V$=$NB>!W%+%F%4%j$KF~$l$kHD$r=q$$$F$*$/%U%!%$%k!#(B"
  :type 'file
  :group 'navi2ch-list)

(defcustom navi2ch-list-stay-list-window nil
  "* non-nil $B$J$i!"HD$rA*$s$@$"$HHD0lMw%P%C%U%!$rI=<($7$?$^$^$K$9$k!#(B"
  :type 'boolean
  :group 'navi2ch-list)

(defcustom navi2ch-list-bbstable-url nil
  "*bbstable $B$N(B URL$B!#(B"
  :type 'string
  :group 'navi2ch-list)

(defcustom navi2ch-list-init-open-category nil
  "*non-nil $B$J$i!"HD0lMw$N%+%F%4%j$r%G%U%)%k%H$G$9$Y$F3+$$$FI=<($9$k!#(B"
  :type 'boolean
  :group 'navi2ch-list)

(defcustom navi2ch-list-indent-width 2
  "*$BHD0lMw%P%C%U%!$G$NHDL>$N%$%s%G%s%HI}!#(B"
  :type 'integer
  :group 'navi2ch-list)

(defcustom navi2ch-list-etc-category-name "$B$=$NB>(B"
  "*$B!V$=$NB>!W%+%F%4%j$NL>A0!#(B"
  :type 'string
  :group 'navi2ch-list)

(defcustom navi2ch-list-global-bookmark-category-name "$B%V%C%/%^!<%/(B"
  "*$B!V%V%C%/%^!<%/!W%+%F%4%j$NL>A0!#(B"
  :type 'string
  :group 'navi2ch-list)

(defcustom navi2ch-list-sync-update-on-boot t
  "*non-nil $B$J$i!"(Bnavi2ch $B5/F0;~$K>o$KHD0lMw$r<h$j$K$$$/!#(B
nil $B$J$i$P<jF0$G99?7$7$J$$$+$.$j<h$j$K$$$+$J$$!#(B"
  :type 'boolean
  :group 'navi2ch-list)

(defcustom navi2ch-list-load-category-list t
  "*non-nil $B$J$i!"A02s$N=*N;;~$K3+$$$F$$$?%+%F%4%j$r5/F0;~$K:F$S3+$/!#(B"
  :type 'boolean
  :group 'navi2ch-list)

(defcustom navi2ch-list-valid-host-regexp
  (concat "\\("
	  (regexp-opt '(".2ch.net" ".bbspink.com" ".machibbs.com" ".machi.to"))
	  "\\)\\'")
  "*$B#2$A$c$s$M$k$NHD$H$_$J$9%[%9%H$N@55,I=8=!#(B"
  :type 'regexp
  :group 'navi2ch-list)

(defcustom navi2ch-list-invalid-host-regexp
  (concat "\\`\\("
	  (regexp-opt '("find.2ch.net" "info.2ch.net"))
	  "\\)\\'")
  "*$B#2$A$c$s$M$k$NHD$H$_$J$5$J$$%[%9%H$N@55,I=8=!#(B
`navi2ch-list-valid-host-regexp' $B$h$jM%@h$5$l$k!#(B"
  :type 'regexp
  :group 'navi2ch-list)

(defcustom navi2ch-list-board-id-alist nil
  "*$BHD(B URL $B$+$i(B board-id $B$X$N(B alist$B!#(B"
  :type '(repeat (cons (string :tag "URL") (string :tag "id")))
  :group 'navi2ch-list)

(defcustom navi2ch-list-mouse-face 'highlight
  "$B%j%9%H%b!<%I$GHD$r%]%$%s%H$7$?;~$K;HMQ$9$k%U%'%$%9!#(B"
  :type '(choice (face :tag "$B%U%'%$%9$r;XDj(B")
		 (const :tag "$B%U%'%$%9$r;HMQ$7$J$$(B" nil))
  :group 'navi2ch-list)

(defcustom navi2ch-list-filter-list nil
  "*$B%9%l%C%I$NJ,N`0lMw$r$$$8$k%U%#%k%?!<$N%j%9%H!#(B
$B$=$l$>$l$N%U%#%k%?!<$O(B elisp $B$N4X?t$J$i$P(B $B$=$N(B symbol$B!"(B
$B30It%W%m%0%i%`$r8F$V$J$i(B
'(\"perl\" \"2ch.pl\")
$B$H$$$C$?46$8$N(B list $B$r@_Dj$9$k!#(B
$BNc$($P$3$s$J46$8!#(B
\(setq navi2ch-list-filter-list
      '(navi2ch-filter
        (\"perl\" \"2ch.pl\")
        (\"perl\" \"filter-with-board.pl\" \"-b\" board)
        ))"
  :type '(repeat sexp)
  :group 'navi2ch-list)

(defcustom navi2ch-list-moved-board-alist nil
  "*$B0\E>$7$?HD$N?75l(B URL $B$N(B alist$B!#(B
http://pc.2ch.net/unix/ $B$,(B http://pc3.2ch.net/unix/ $B$K0\E>$7$?>l9g!"(B
\((\"http://pc.2ch.net/unix/\" . \"http://pc3.2ch.net/unix/\"))
$B$N$h$&$K;XDj$9$k!#(B"
  :type '(alist :key-type (string :tag "$B0\E>A0$N(B URL")
		:value-type (string :tag "$B0\E>8e$N(B URL"))
  :group 'navi2ch-list)

(defcustom navi2ch-list-display-board-id-p t
  "*$BHD0lMw$KHD(BID$B$rI=<($9$k$+$I$&$+!#(B
non-nil $B$J$i$PHD(BID$B$rI=<($9$k!#(B"
  :type 'boolean
  :group 'navi2ch-list)

(defcustom navi2ch-list-board-id-column 20
  "*$BHD(BID$B$rI=<($9$k0LCV!#(B"
  :type 'integer
  :group 'navi2ch-list)

;;; board variables
(defcustom navi2ch-board-max-line nil
  "*$B%@%&%s%m!<%I$9$k(B subject.txt $B$N9T?t!#(Bnil $B$J$iA4It%@%&%s%m!<%I$9$k!#(B"
  :type '(choice (integer :tag "$B9T?t$r;XDj(B")
		 (const :tag "$BA4$F(B" nil))
  :group 'navi2ch-board)

(defcustom navi2ch-board-expire-date 30
  "*$B:G8e$KJQ99$5$l$F$+$i$3$NF|?t0J>e$?$C$?%U%!%$%k$O(B expire ($B:o=|(B)$B$5$l$k!#(B
nil $B$J$i(B expire $B$7$J$$!#(B"
  :type '(choice (integer :tag "$BF|?t$r;XDj(B")
		 (const :tag "expire $B$7$J$$(B" nil))
  :group 'navi2ch-board)

(defcustom navi2ch-board-expire-bookmark-p nil
  "*expire $B$9$k$H$-$K(B bookmark $B$5$l$F$$$k%9%l$b(B expire $B$9$k$+$I$&$+!#(B
non-nil $B$J$i$P(B expire $B$9$k!#(B"
  :type 'boolean
  :group 'navi2ch-board)

(defcustom navi2ch-board-expire-orphan-only nil
  "*non-nil $B$J$i%*%k%U%!%s$J%9%l$N$_$r(B expire $B$9$k!#(B
$B%*%k%U%!%s$J%9%l$H$O!"HD$N(B subject.txt $B$K$b%0%m!<%P%k%V%C%/%^!<%/$K$b(B
$BEPO?$5$l$F$J$$%9%l$N$3$H!#(B"
  :type 'boolean
  :group 'navi2ch-board)

(defcustom navi2ch-board-window-height 10
  "*$B%9%l$N0lMw$rI=<($9$k(B board window $B$N9b$5!#(B"
  :type 'integer
  :group 'navi2ch-board)

(defcustom navi2ch-board-check-updated-article-p t
  "*non-nil $B$J$i!"?7$7$$%l%9$,$"$C$?$+%A%'%C%/$9$k!#(B"
  :type 'boolean
  :group 'navi2ch-board)

(defcustom navi2ch-board-view-logo-program
  (if (eq window-system 'w32)
      "fiber"
    "xv")
  "*$B%m%4$r8+$k$N$K;H$&%W%m%0%i%`!#(B"
  :type 'file
  :group 'navi2ch-board)

(defcustom navi2ch-board-view-logo-args nil
  "*$B%m%4$r8+$k$N$K;H$&%W%m%0%i%`$N0z?t!#(B"
  :type '(repeat (string :tag "$B0z?t(B"))
  :group 'navi2ch-board)

(defcustom navi2ch-board-delete-old-logo t
  "*non-nil $B$J$i!"?7$7$$%m%4$r%@%&%s%m!<%I$7$?$H$-$K8E$$%m%4$r>C$9!#(B"
  :type 'boolean
  :group 'navi2ch-board)

(defcustom navi2ch-board-hide-updated-article nil
  "*non-nil $B$J$i!"(Bnavi2ch-board-updated-mode $B$G(B hide $B$5$l$?%9%l%C%I$rI=<($7$J$$!#(B"
  :type 'boolean
  :group 'navi2ch-board)

(defcustom navi2ch-bm-subject-width 50
  "*$B3F%9%l$NBjL>$NI}!#(B"
  :type 'integer
  :group 'navi2ch-board)

(defcustom navi2ch-bm-number-width 3
  "*$B3F%9%l$N%9%lHV9fMs$NI}!#(B"
  :type 'integer
  :group 'navi2ch-board)

(defcustom navi2ch-bm-mark-and-move t
  "*$B%^!<%/$7$?$"$H$N%]%$%s%?$NF0:n!#(B
nil $B$J$i0\F0$7$J$$(B
non-nil $B$J$i2<$K0\F0$9$k(B
'follow $B$J$i0JA00\F0$7$?J}8~$K0\F0$9$k(B"
  :type '(choice (const :tag "$B0\F0$7$J$$(B" nil)
		 (const :tag "$B2<$K0\F0(B" t)
		 (const :tag "$B0JA00\F0$7$?J}8~$K0\F0(B" follow))
  :group 'navi2ch-board)

(defcustom navi2ch-bm-empty-subject "navi2ch: no subject"
  "*subject $B$,L5$$$H$-$KBe$jI=<($9$k(B subject$B!#(B"
  :type 'string
  :group 'navi2ch-board)

(defcustom navi2ch-history-max-line 100
  "*$B%R%9%H%j$N9T?t$N@)8B!#(Bnil $B$J$i$P@)8B$7$J$$!#(B"
  :type '(choice (integer :tag "$B:GBg$N9T?t$r;XDj(B")
		 (const :tag "$B@)8B$7$J$$(B" nil))
  :group 'navi2ch-board)

(defcustom navi2ch-bm-stay-board-window t
  "*non-nil $B$J$i!"%9%l$rA*$s$@$H$-$K%9%l0lMw$rI=<($7$?$^$^$K$9$k!#(B"
  :type 'boolean
  :group 'navi2ch-board)

(defcustom navi2ch-bm-fetched-info-file "fetched.txt"
  "*$B4{FI%9%l$N%j%9%H$rJ]B8$7$F$*$/%U%!%$%k!#(B"
  :type 'file
  :group 'navi2ch-board)

(defcustom navi2ch-bookmark-file "bookmark2.txt"
  "*$B%0%m!<%P%k%V%C%/%^!<%/$rJ]B8$7$F$*$/%U%!%$%k!#(B"
  :type 'file
  :group 'navi2ch-board)

(defcustom navi2ch-bookmark-remember-order-after-sort nil
  "*bookmark $B%b!<%I$G(B sort $B8e$N%9%lJB$S=g$r5-21$9$k$+$I$&$+!#(B
non-nil $B$J$i$P5-21$9$k!#(B"
  :type 'boolean
  :group 'navi2ch-board)

(defcustom navi2ch-history-file "history.txt"
  "*$B%R%9%H%j$rJ]B8$7$F$*$/%U%!%$%k!#(B"
  :type 'file
  :group 'navi2ch-board)

(defcustom navi2ch-board-name-from-file "From File"
  "*$B%U%!%$%k$+$iFI$_9~$s$@%9%l$rI=$9HDL>!#(B"
  :type 'string
  :group 'navi2ch-board)

(defcustom navi2ch-bm-mouse-face 'highlight
  "*$BHD$G%9%l$r%]%$%s%H$7$?;~$K;HMQ$9$k%U%'%$%9!#(B"
  :type '(choice (face :tag "$B%U%'%$%9$r;XDj(B")
		 (const :tag "$B%U%'%$%9$r;HMQ$7$J$$(B" nil))
  :group 'navi2ch-board)

(defcustom navi2ch-bm-sort-by-state-order
  '(("%U" . 0)
    ("+U" . 1)
    ("%V" . 2)
    ("+V" . 3)
    ("%C" . 4)
    ("+C" . 5)
    ("% " . 6)
    ("+ " . 7)
    (" U" . 8)
    (" V" . 9)
    (" C" . 10)
    ("  " . 11)
    ("=U" . 12)
    ("=V" . 13)
    ("=C" . 14)
    ("= " . 15))
  "*$B>uBV$G%=!<%H$9$k$H$-$N=g=x$r7h$a$k%j%9%H!#(B"
  :type '(list (cons (const :tag "$B>uBV(B %U" "%U") (number :tag "$B=gHV(B"))
	       (cons (const :tag "$B>uBV(B %V" "%V") (number :tag "$B=gHV(B"))
	       (cons (const :tag "$B>uBV(B %C" "%C") (number :tag "$B=gHV(B"))
	       (cons (const :tag "$B>uBV(B % " "% ") (number :tag "$B=gHV(B"))
	       (cons (const :tag "$B>uBV(B +U" "+U") (number :tag "$B=gHV(B"))
	       (cons (const :tag "$B>uBV(B +V" "+V") (number :tag "$B=gHV(B"))
	       (cons (const :tag "$B>uBV(B +C" "+C") (number :tag "$B=gHV(B"))
	       (cons (const :tag "$B>uBV(B + " "+ ") (number :tag "$B=gHV(B"))
	       (cons (const :tag "$B>uBV(B  U" " U") (number :tag "$B=gHV(B"))
	       (cons (const :tag "$B>uBV(B  V" " V") (number :tag "$B=gHV(B"))
	       (cons (const :tag "$B>uBV(B  C" " C") (number :tag "$B=gHV(B"))
	       (cons (const :tag "$B>uBV(B   " "  ") (number :tag "$B=gHV(B"))
	       (cons (const :tag "$B>uBV(B =U" "=U") (number :tag "$B=gHV(B"))
	       (cons (const :tag "$B>uBV(B =V" "=V") (number :tag "$B=gHV(B"))
	       (cons (const :tag "$B>uBV(B =C" "=C") (number :tag "$B=gHV(B"))
	       (cons (const :tag "$B>uBV(B = " "= ") (number :tag "$B=gHV(B"))
	       (cons (const :tag "$B>uBV(B   " "  ") (number :tag "$B=gHV(B")))
  :group 'navi2ch-board)

(defcustom navi2ch-board-filter-list nil
  "*$B%9%l%C%I$N0lMw$r$$$8$k%U%#%k%?!<$N%j%9%H!#(B
$B$=$l$>$l$N%U%#%k%?!<$O(B elisp $B$N4X?t$J$i$P(B $B$=$N(B symbol$B!"(B
$B30It%W%m%0%i%`$r8F$V$J$i(B
'(\"perl\" \"2ch.pl\")
$B$H$$$C$?46$8$N(B list $B$r@_Dj$9$k!#(B
$BNc$($P$3$s$J46$8!#(B
\(setq navi2ch-board-filter-list
      '(navi2ch-filter
        (\"perl\" \"2ch.pl\")
        (\"perl\" \"filter-with-board.pl\" \"-b\" board)
        ))"
  :type '(repeat sexp)
  :group 'navi2ch-board)

(defcustom navi2ch-board-check-article-update-suppression-length nil
  "*$B%9%l$r99?7$9$k:]!"%U%#%k%?!<=hM}$r%A%'%C%/$9$k?7Ce%l%9?t!#(B

$B$?$H$($P(B 10 $B$r;XDj$9$k$H!"(B
$B%9%l$N?7Ce%l%9$,(B10$B8D0J2<$G$=$N$9$Y$F$,HsI=<($K$J$k$H$-$O!"(B
$B?7Ce$J$7$H8+$J$5$l$k!#(B

nil $B$r;XDj$9$k$H!"?7Ce%l%9$X$N%U%#%k%?!<=hM}$r%A%'%C%/$7$J$$!#(B"
  :type '(choice (integer :tag "$B?7Ce%l%9?t(B")
		 (const :tag "$B%A%'%C%/$7$J$$(B" nil))
  :group 'navi2ch-board)

(defcustom navi2ch-board-insert-subject-with-diff nil
  "*non-nil $B$J$i!"(BBoard $B%b!<%I$N%l%9?tMs$K%l%9$NA}2C?t$rI=<($9$k!#(B"
  :type 'boolean
  :group 'navi2ch-board)

(defcustom navi2ch-board-insert-subject-with-unread nil
  "*non-nil $B$J$i!"(BBoard $B%b!<%I$N%l%9?tMs$K%l%9$NL$FI?t$rI=<($9$k!#(B"
  :type 'boolean
  :group 'navi2ch-board)

(defcustom navi2ch-board-coding-system-alist
  nil
  "*$BHD$KBP$7$F6/@)E*$K(B coding-system $B$r;XDj$9$k0Y$N(B alist$B!#(B
$B3FMWAG$O!"(B(BOARD-ID . CODING-SYSTEM)$B!#(B
BOARD-ID $B$OHD(BID$B!#(B
CODING-SYSTEM $B$O(B BOARD-ID $B$G;XDj$5$l$kHD$K;XDj$9$k(B coding-system$B!#(B"
  :type `(repeat
	  (cons
	   (string :tag "$BHD(BID")
	   (choice :tag "$BJ8;z%3!<%I(B"
		   :value ,navi2ch-coding-system
		   ,@(mapcar (lambda (x)
			       (list 'const x))
			     (coding-system-list)))))
  :group 'navi2ch-board)

;;; article variables
(defcustom navi2ch-article-aadisplay-program
  (if (eq window-system 'w32)
      "notepad"
    "aadisplay")
  "*AA $B$rI=<($9$k$?$a$K;H$&%W%m%0%i%`!#(B"
  :type 'string
  :group 'navi2ch-article)

(defcustom navi2ch-article-aadisplay-coding-system
  (if (eq window-system 'w32)
      'shift_jis-dos
    'euc-jp-unix)
  "*AA $B$rI=<($9$k%W%m%0%i%`$K$o$?$90l;~%U%!%$%k$N(B `coding-system'$B!#(B"
  :type 'coding-system
  :group 'navi2ch-article)

(defcustom navi2ch-article-view-aa-function
  (if (eq window-system 'w32)
      'navi2ch-article-popup-dialog
    'navi2ch-article-call-aadisplay)
  "*AA $B$rI=<($9$k$?$a$K;H$&4X?t!#(B"
  :type 'function
  :group 'navi2ch-article)

(defcustom navi2ch-article-enable-diff t
  "*non-nil $B$J$i%U%!%$%k$N:9J,<hF@$,M-8z$K$J$k!#(B
nil $B$K$9$k$H>o$K%U%!%$%kA4BN$rE>Aw$9$k!#(B"
  :type 'boolean
  :group 'navi2ch-article)

(defcustom navi2ch-article-max-line nil
  "*$B%@%&%s%m!<%I$9$k5-;v$N9T?t!#(Bnil $B$J$i;D$j$r$9$Y$F%@%&%s%m!<%I$9$k!#(B"
  :type '(choice (integer :tag "$B7o?t$r;XDj(B")
		 (const :tag "$BA4$F(B" nil))
  :group 'navi2ch-article)

(defcustom navi2ch-article-enable-fill nil
  "*non-nil $B$J$i!"%9%l$N%a%C%;!<%8$r(B fill-region $B$9$k!#(B"
  :type 'boolean
  :group 'navi2ch-article)

(defcustom navi2ch-article-enable-fill-list nil
  "*fill-region $B$9$kHD$N%j%9%H!#(B"
  :type '(repeat string)
  :group 'navi2ch-article)

(defcustom navi2ch-article-disable-fill-list nil
  "*fill-region $B$7$J$$HD$N%j%9%H!#(B"
  :type '(repeat string)
  :group 'navi2ch-article)

(defcustom navi2ch-article-enable-through 'ask-always
  "*$B%9%l%C%I$N:G8e$G%9%Z!<%9$r2!$7$?$H$-$K<!$N%9%l%C%I$K0\F0$9$k$+!#(B
nil $B$J$i0\F0$7$J$$(B
ask-always $B$J$i0\F0$9$kA0$KI,$:<ALd$9$k(B
ask $B$J$iL@<(E*$K0\F0$9$k;~0J30$J$i<ALd$9$k(B
$B$=$l0J30$N(B non-nil $B$JCM$J$i2?$bJ9$+$:$K0\F0$9$k!#(B"
  :type '(choice (const :tag "$B$$$D$G$b<ALd$9$k(B" ask-always)
		 (const :tag "$BL@<(E*$K0\F0$9$k$H$-0J30$O<ALd$9$k(B" ask)
		 (const :tag "$BJ9$+$:$K0\F0(B" t)
		 (const :tag "$B0\F0$7$J$$(B" nil))
  :group 'navi2ch-article)

(defcustom navi2ch-article-through-ask-function
  #'navi2ch-article-through-ask-y-or-n-p
  "*$B<!$N%9%l%C%I$K0\F0$9$k$H$-$N3NG'$K;HMQ$9$k4X?t!#(B"
  :type '(choice (const :tag "y or n $B$G3NG'(B"
			navi2ch-article-through-ask-y-or-n-p)
		 (const :tag "n $B$^$?$O(B p $B$G3NG'(B"
			navi2ch-article-through-ask-n-or-p-p)
		 (const :tag "$BD>A0$N%3%^%s%I$HF1$8$+$G3NG'(B"
			navi2ch-article-through-ask-last-command-p))
  :group 'navi2ch-article)

(defcustom navi2ch-article-parse-field-list '(data name mail)
  "*$B%a%C%;!<%8$N%U%#!<%k%I$N$&$A!"%Q!<%:BP>]$K$9$k$b$N$N%j%9%H!#(B
$BCY$/$F$b$$$$$s$J$i(B '(data mail name) $B$H$+$9$k$H$$$$$+$b(B"
  :type '(set (const :tag "$B5-;v(B" data)
              (const :tag "$B%a!<%k(B" mail)
              (const :tag "$BL>A0(B" name))
  :group 'navi2ch-article)

(defcustom navi2ch-article-goto-number-recenter t
  "*non-nil $B$J$i!"(Bgoto-number $B$7$?$"$H(B recenter $B$9$k!#(B"
  :type 'boolean
  :group 'navi2ch-article)

(defcustom navi2ch-article-new-message-range '(100 . 1)
  "*$B%9%l$N%G%U%)%k%H$NI=<(HO0O!#=i$a$FFI$`%9%l$KE,MQ$9$k!#(B

$B$?$H$($P(B '(100 5) $B$r;XDj$9$k$H!"(Bnavi2ch $B$O%9%l$N@hF,$+$i(B100$B8D!"(B
$BKvHx$+$i(B5$B8D$N%a%C%;!<%8$@$1$r%P%C%U%!$KA^F~$7!"$=$N$"$$$@$N(B
$B%a%C%;!<%8$K$D$$$F$O=hM}$rHt$P$9!#(B"
  :type '(cons integer integer)
  :group 'navi2ch-article)

(defcustom navi2ch-article-exist-message-range '(1 . 100)
  "*$B%9%l$N%G%U%)%k%H$NI=<(HO0O!#4{FI%9%l$KE,MQ$9$k!#(B"
  :type '(cons integer integer)
  :group 'navi2ch-article)

(defcustom navi2ch-article-auto-range t
  "*non-nil $B$J$i!"$^$@I=<($7$F$J$$%9%l%C%I$NI=<(HO0O$r>!<j$K69$a$k!#(B"
  :type 'boolean
  :group 'navi2ch-article)

(defcustom navi2ch-article-view-range-list
  '((1 . 50)
    (50 . 50)
    (1 . 100)
    (100 . 100))
  "*$B%9%l$NI=<(HO0O$rJQ$($k$H$-A*Br8uJd$H$7$F;H$&%j%9%H!#(B"
  :type '(repeat (cons integer integer))
  :group 'navi2ch-article)

(defcustom navi2ch-article-header-format-function
  'navi2ch-article-default-header-format-function
  "*NUMBER NAME MAIL DATE $B$r0z?t$K<h$j!"%l%9$N%X%C%@$rJV$94X?t!#(B"
  :type 'function
  :group 'navi2ch-article)

(defcustom navi2ch-article-citation-regexp
  "^[>$B!d(B]\\($\\|[^$>$B!d(B0-9$B#0(B-$B#9(B].*\\)"
  "*$B%l%9$N0zMQItJ,$N@55,I=8=!#(B"
  :type 'regexp
  :group 'navi2ch-article)

(defcustom navi2ch-article-number-prefix-regexp "[>$B!d"d(B<$B!c(B][>$B!d"d(B<$B!c(B]* *"
  "*$BF1$8%9%lFb$X$N%j%s%/$rI=$9@55,I=8=!#(B"
  :type 'regexp
  :group 'navi2ch-article)

(defcustom navi2ch-article-number-separator-regexp " *[,$B!"(B=$B!a(B] *"
  "*$BF1$8%9%lFb$X$N%j%s%/$N?t;z$r6h@Z$kJ8;zNs$rI=$9@55,I=8=!#(B"
  :type 'regexp
  :group 'navi2ch-article)

(defcustom navi2ch-article-number-number-regexp
  "\\([0-9$B#0(B-$B#9(B]+\\(-[0-9$B#0(B-$B#9(B]+\\)?\\)"
  "*$BF1$8%9%lFb$X$N%j%s%/$N?t;z$rI=$9@55,I=8=!#(B"
  :type 'regexp
  :group 'navi2ch-article)

(defcustom navi2ch-article-select-current-link-number-style 'auto
  "*$B%9%lFb%j%s%/(B (>>3 $B$H$+(B) $B$r$?$I$k$H$-$NI=<(J}K!!#(B
'popup $B$J$i$D$M$KJL%&%#%s%I%&$r(B popup $B$9$k!#(B
'jump $B$J$i(B popup $B$;$:$K0\F0$9$k!#(B
'auto $B$J$i<+F0$G@Z$jBX$($k!#(B"
  :type '(choice (const :tag "Popup" popup)
                 (const :tag "Jump" jump)
		 (const :tag "Auto" auto))
  :group 'navi2ch-article)

;; <http://www.ietf.org/rfc/rfc2396.txt>
;;       URI-reference = [ absoluteURI | relativeURI ] [ "#" fragment ]
;;       uric          = reserved | unreserved | escaped
;;       reserved      = ";" | "/" | "?" | ":" | "@" | "&" | "=" | "+" |
;;                       "$" | ","
;;       unreserved    = alphanum | mark
;;       mark          = "-" | "_" | "." | "!" | "~" | "*" | "'" |
;;                       "(" | ")"
(defcustom navi2ch-article-url-regexp
  "\\(h?t?tps?\\|x-localbbs\\|ftp\\|sssp\\)\\(://[-a-zA-Z0-9_.!~*';/?:@&=+$,%#]+\\)"
  "*$B%l%9$N%F%-%9%H$N$&$A(B URL $B$H$_$J$9ItJ,$N@55,I=8=!#(B"
  ;; "(" ")" $B$O(B URL $B$r0O$`0UL#$G;H$o$l$k>l9g$,B?$$$h$&$J$N$G4^$a$J$$(B
  :type 'regexp
  :group 'navi2ch-article)

(defcustom navi2ch-article-link-regexp-alist
  (if (= (regexp-opt-depth "\\(\\(\\)\\)") 1)
      nil ;; $B%P%0;}$A(B regexp-opt-depth()
    '(("<\\(UR[IL]:\\)?\\([^:>]+\\)>" . nil)
      ("\\<h?t?tp:\\(//www.amazon.co.jp/exec/obidos/ASIN/[0-9A-Z]+\\)/?"
       . "http:\\1/")
      ("\\<h?t?tp://\\(ime\\.nu/\\)+\\([-a-zA-Z0-9_.!~*';/?:@&=+$,%#]+\\)"
       . "http://\\2")
      ("(h?t?tp\\(s?://[-a-zA-Z0-9_.!~*'();/?:@&=+$,%#]+\\))"
       . "http\\1")
      ("h?t?tp\\(s?://[-a-zA-Z0-9_.!~*'();/?:@&=+$,%#]+\\)"
       . "http\\1")
      ("<\\(UR[IL]:\\)?\\([a-z][-+.0-9a-z]*:[^>]*\\)>" . "\\2")))
  "*$B3FMWAG$N(B car $B$r@55,I=8=$H$7!"%^%C%A$7$?%F%-%9%H$K(B cdr $B$X$N%j%s%/$rD%$k!#(B
$BCV49@h$K;H$($kFC<lJ8;z$K$D$$$F$O(B `replace-match' $BEy$r;2>H!#(B
cdr $B$,(B nil $B$N>l9g$O%j%s%/$rE=$i$J$$!#(B
cdr $B$,4X?t$N>l9g$O%^%C%A$7$?J8;zNs$r0z?t$H$7$F8F$S=P$7!"JV5QCM$,J8;zNs(B
$B$N>l9g!"$=$l$r%j%s%/$H$9$k!#$=$N:]!"FC<lJ8;z$O;H$($J$$!#(B
$B%j%9%H$N@hF,$rM%@h$7!"F1$8J8;zNs$K$O0lEY$@$1%^%C%A$9$k!#(B
`navi2ch-article-url-regexp' $B$h$jM%@h$5$l$k!#(B

URL $B$8$c$J$$J*$K%j%s%/$rE=$k(B:
'((\"\\\\=\\[\\\\(FreeBSD-[a-z]+-jp\\\\) \\\\([0-9]+\\\\)\\\\]\" .
   \"http://home.jp.freebsd.org/cgi-bin/showmail/\\\\1/\\\\2\"))

$BCV49@h$K4X?t$r;HMQ(B:
'(\"\\\\=\\[postfix-jp: *\\\\([0-9]+\\\\)\\\\]\" .
  (lambda (str)
    (format \"http://www.kobitosan.net/postfix/ML/arc-2.1/msg%05d.html\"
            (1- (string-to-number (match-string 1))))))"
  :type '(repeat (cons (regexp :tag "$B%^%C%A$9$k@55,I=8=(B")
		       (choice (const :tag "$B%j%s%/$rE=$i$J$$(B"
				      :value nil)
			       (string :tag "$BCV49$9$kJ8;zNs(B")
			       (function :tag "$BCV49$KMxMQ$9$k4X?t(B"))))
  :group 'navi2ch-article)

(defcustom navi2ch-list-filter-list nil
  "*$B%9%l%C%I$NJ,N`0lMw$r$$$8$k%U%#%k%?!<$N%j%9%H!#(B
$B$=$l$>$l$N%U%#%k%?!<$O(B elisp $B$N4X?t$J$i$P(B $B$=$N(B symbol$B!"(B
$B30It%W%m%0%i%`$r8F$V$J$i(B
'(\"perl\" \"2ch.pl\")
$B$H$$$C$?46$8$N(B list $B$r@_Dj$9$k!#(B
$BNc$($P$3$s$J46$8!#(B
\(setq navi2ch-list-filter-list
      '(navi2ch-filter
        (\"perl\" \"2ch.pl\")
        (\"perl\" \"filter-with-board.pl\" \"-b\" board)
        ))"
  :type '(repeat sexp)
  :group 'navi2ch-list)

(defcustom navi2ch-article-filter-list nil
  "*$B%9%l%C%I$N5-;v$r$$$8$k%U%#%k%?!<$N%j%9%H!#(B
$B$=$l$>$l$N%U%#%k%?!<$O(B elisp $B$N4X?t$J$i$P(B $B$=$N(B symbol$B!"(B
$B30It%W%m%0%i%`$r8F$V$J$i(B
'(\"perl\" \"2ch.pl\")
$B$H$$$C$?46$8$N(B list $B$r@_Dj$9$k!#(B
$BHD(BID$B$r0z?t$G;XDj$9$k$J$i(B board $B$H$$$&%7%s%\%k$rHDL>$rEO$7$?$$>l=j$K=q$/!#(B
$BNc$($P$3$s$J46$8!#(B
\(setq navi2ch-article-filter-list
      '(navi2ch-filter
        (\"perl\" \"2ch.pl\")
        (\"perl\" \"filter-with-board.pl\" \"-b\" board)
        ))

$B5l7A<0$N%;%Q%l!<%?$r;HMQ$7$?(B .dat $B%U%!%$%k$r07$$$?$$>l9g!"$3$NJQ?t$K(B
$B%7%s%\%k(B navi2ch-article-separator-filter $B$rDI2C$9$k!#(B"
  :type '(repeat (choice (const :tag "$B5l7A<0(B .dat $BMQ%U%#%k%?(B"
				:value navi2ch-article-separator-filter)
			 sexp))
  :group 'navi2ch-article)

(defcustom navi2ch-article-redraw-when-goto-number t
  "*non-nil $B$J$i!"(B`navi2ch-article-goto-number' $B$7$?$H$3$m$,HO0O30$N$H$-(B
$B<+F0$G(B redraw $B$7$J$*$9!#(B"
  :type 'boolean
  :group 'navi2ch-article)

(defcustom navi2ch-article-fix-range-diff 10
  "*`navi2ch-article-fix-range' $B$7$?$H$-$KLa$k%l%9$N?t!#(B"
  :type 'integer
  :group 'navi2ch-article)

(defcustom navi2ch-article-fix-range-when-sync t
  "*non-nil $B$J$i!"(B`navi2ch-article-sync' $B$GHO0O30$N$H$-(B
$B<+F0E*$K(B `navi2ch-article-view-range' $B$rJQ99$9$k!#(B"
  :type 'boolean
  :group 'navi2ch-article)

(defcustom navi2ch-article-message-separator ?_
  "*$B%l%9$H%l%9$N6h@Z$j$K;H$&J8;z!#(B"
  :type 'character
  :group 'navi2ch-article)

(defcustom navi2ch-article-message-separator-width '(/ (window-width) 2)
  "*$B%l%9$H%l%9$r6h@Z$k%F%-%9%H$N2#I}!#(B
$BI}$r(B 80 $BJ8;z$K$7$?$$$J$i(B
\(setq navi2ch-article-message-separator-width 80)
window $B$NI}$$$C$Q$$$K$7$?$$$J$i(B
\(setq navi2ch-article-message-separator-width '(window-width))
$BEy;XDj$9$k!#(B"
  :type 'sexp
  :group 'navi2ch-article)

(defcustom navi2ch-article-message-separator-insert-hide-number-p t
  "*hide $B>pJs$r%l%9$H%l%9$N6h@Z$j$KI=<($9$k$+!#(B"
  :type 'boolean
  :group 'navi2ch-article)

(defcustom navi2ch-article-message-separator-insert-trailing-newline-p t
  "*$B%l%9$N6h@Z$j$N8e$K$b$&0l8D2~9T$rI=<($9$k$+!#(B"
  :type 'boolean
  :group 'navi2ch-article)

(defcustom navi2ch-article-auto-expunge nil
  "*non-nil $B$J$i!"%P%C%U%!$H$7$FJ];}$9$k%9%l$N?t$r(B
`navi2ch-article-max-buffers' $B0J2<$KJ]$D!#$3$N@)8BCM$rD6$($?$H$-$K$O!"(B
$B$$$A$P$s8E$$%P%C%U%!$r<+F0E*$K>C$9!#(B"
  :type 'boolean
  :group 'navi2ch-article)

(defcustom navi2ch-article-max-buffers 20
  "*$B%P%C%U%!$H$7$FJ];}$9$k%9%l$N:GBg?t!#(B0 $B$J$i$PL5@)8B!#(B"
  :type '(choice (const :tag "$BL5@)8B(B" 0)
                 (integer :tag "$B@)8BCM(B"))
  :group 'navi2ch-article)

(defcustom navi2ch-article-cleanup-white-space-after-old-br t
  "*non-nil $B$J$i!"8E$$7A<0$N(B <br> $B$KBP1~$7$F9TF,$+$i6uGr$r<h$j=|$/!#(B
$B$?$@$7!"$9$Y$F$N(B <br> $B$ND>8e$K6uGr$,$"$k>l9g$K8B$k!#(B"
  :type 'boolean
  :group 'navi2ch-article)

(defcustom navi2ch-article-cleanup-trailing-whitespace t
  "*non-nil $B$J$i!"%9%l$N3F9T$+$iKvHx$N6uGr$r<h$j=|$/!#(B"
  :type 'boolean
  :group 'navi2ch-article)

(defcustom navi2ch-article-cleanup-trailing-newline t
  "*non-nil $B$J$i!"%9%l$N3F%l%9$+$iKvHx$N6u9T$r<h$j=|$/!#(B"
  :type 'boolean
  :group 'navi2ch-article)

(defcustom navi2ch-article-display-link-width '(1- (window-width))
  "*$B%9%l$N%j%s%/@h$J$I$r(B minibuffer $B$KI=<($9$k$H$-$NJ8;zNs$N:GBgD9!#(B
$B$3$l$h$jD9$$%F%-%9%H$O@Z$j5M$a$i$l$k!#(B
$B?tCM$N$[$+!"(Beval $B$G?tCM$rJV$9G$0U$N(B S $B<0$r;XDj$G$-$k!#(B"
  :type '(choice (integer :tag "$B?tCM$G;XDj(B")
                 (sexp :tag "$B4X?t$H$+(B"))
  :group 'navi2ch-article)

(defcustom navi2ch-article-auto-decode-p nil
  "*non-nil $B$J$i!"%9%l$N%(%s%3!<%I$5$l$?%F%-%9%H$r<+F0E83+$9$k!#(B"
  :type 'boolean
  :group 'navi2ch-article)

(defcustom navi2ch-article-auto-decode-insert-text nil
  "*non-nil $B$J$i!"<+F0E83+$7$?%F%-%9%H$r%P%C%U%!$KA^F~$9$k!#(B
`navi2ch-article-auto-decode-p' $B$,(B non-nil $B$N$H$-$N$_8z2L$,$"$k!#(B"
  :type 'boolean
  :group 'navi2ch-article)

(defcustom navi2ch-article-show-url-number 50
  "*url $B$rI=<(!&%3%T!<$9$k:]!":G8e$N%l%9$r$$$/$DI=<($9$k$+!#(B"
  :type 'number
  :group 'navi2ch-article)

(defcustom navi2ch-article-mouse-face 'highlight
  "*$B%9%l$G%j%s%/$r%]%$%s%H$7$?;~$K;HMQ$9$k%U%'%$%9!#(B"
  :type '(choice (face :tag "$B%U%'%$%9$r;XDj(B")
		 (const :tag "$B%U%'%$%9$r;HMQ$7$J$$(B" nil))
  :group 'navi2ch-article)

(defcustom navi2ch-article-get-url-text t
  "* non-nil $B$J$i(B `navi2ch-article-get-link-text' $B$G(B URL $B$N%j%s%/@h$rF@$k!#(B
nil $B$N>l9g$OF1$8%9%l$NFbMF$N$_$rF@$k!#(B"
  :type 'boolean
  :group 'navi2ch-article)

(defcustom navi2ch-article-date-format-function
  'identity
  "* $B%l%9$NF|IU$r%U%)!<%^%C%H$9$k4X?t!#(B
`navi2ch-article-default-header-format-function' $B$+$i!"(BDATE $B$r0z?t(B
$B$H$7$F8F$S=P$5$l$k!#(B"
  :type '(choice (const :tag "$BJQ99$7$J$$(B"
			:value identity)
		 (const :tag "Be2ch $B$K%j%s%/$rDI2C$9$k(B"
			:value navi2ch-article-date-format-be2ch)
		 (function :tag "$B4X?t$r;XDj(B"))
  :group 'navi2ch-article)

(defcustom navi2ch-article-message-filter-list
  '(navi2ch-article-message-filter-by-name
    navi2ch-article-message-filter-by-mail
    navi2ch-article-message-filter-by-id
    navi2ch-article-message-filter-by-message
    navi2ch-article-message-filter-by-subject
    navi2ch-article-message-filter-by-hostname)
  "*$B%l%9$r%U%#%k%?$9$k$?$a$N4X?t$N%j%9%H!#(B
$B%j%9%H$N(B member $B$H$J$k4X?t$H$7$F$O!"(B
$B%l%9$N(B alist $B$r0z$-?t$K<h$j!"(B
$B%U%#%k%?8e$NJ8;zNs$b$7$/$O(B 'hide $B$+(B 'important $B$rJV$9$b$N$r;XDj$9$k!#(B

$B2<5-$OL>A0Ms$,!V$[$2!W$N$H$-$K!V$"$\$\!<$s!W$KCV49$9$k$?$a$N(B
\($B$A$g$C$H>iD9$J(B) $B4X?t$NNc!#(B

\(defun my-navi2ch-article-message-filter-hoge (alist)
  (let ((number (cdr (assq 'number alist)))
	(name (cdr (assq 'name alist)))
	(mail (cdr (assq 'mail alist)))
	(date (cdr (assq 'date alist)))
	(message (cdr (assq 'data alist))))
    (if (equal name \"$B$[$2(B\")
	\"$B$"$\$\!<$s(B\"
      nil)))"
  :type '(repeat function)
  :group 'navi2ch-article)

(defcustom navi2ch-article-message-filter-by-name-alist nil
  "*$B%l%9$r%U%#%k%?$9$k$?$a$NL>A0$N>r7o$H!"%U%#%k%?=hM}$N(B alist$B!#(B

$B>r7o$K$OJ8;zNs$+!"(B
\($BJ8;zNs(B $B%7%s%\%k(B ...)$B$N7A<0$N%j%9%H(B($B3HD%7A<0(B)$B$r;XDj$9$k!#(B

$BJ8;zNs$r;XDj$9$k$H!"(B
$BL>A0$,$=$NJ8;zNs$r4^$`$H$-$K%U%#%k%?=hM}$,<B9T$5$l$k!#(B

$B3HD%7A<0$r;XDj$9$k$H!"(B
$B%7%s%\%k$K9g$o$;$F2<5-$NJ}K!$GL>A0$r8!::$9$k!#(B

S,s	$BItJ,0lCW(B
E,e	$B40A40lCW(B
F,f	$B$"$$$^$$0lCW(B	($B6uGr$d2~9T$NM-L5$dB?>/$rL5;k$7!"(B
			$B$^$?A43Q$HH>3Q$r6hJL$7$J$$ItJ,0lCW(B)
R,r	$B@55,I=8=(B

$BBgJ8;z$N%7%s%\%k$r;XDj$9$k$HJ8;zNs$NBgJ8;z$H>.J8;z$r6hJL$7!"(B
$B>.J8;z$N%7%s%\%k$r;XDj$9$k$HJ8;zNs$NBgJ8;z$H>.J8;z$r6hJL$7$J$$!#(B

$B$"$$$^$$0lCW$r>.J8;z$G;XDj$7$?>l9g$O!"$R$i$,$J$H%+%?%+%J$b6hJL$7$J$$!#(B

$B%7%s%\%k$N8e$K$O%-!<%o!<%I$rDI2C$7!"(B
$BCM$K$h$C$F%U%#%k%?>r7o$r2<5-$N$h$&$KJdB-$9$k$3$H$,$G$-$k!#(B

:invert		t (non-nil)$B$r;XDj$9$k$H!"J8;zNs0lCW$N??56$r5UE>$9$k(B

:board-id	$B%U%#%k%?BP>]$H$J$kHD$N(B ID $B$r;XDj$9$k(B
:artid		$B%U%#%k%?BP>]$H$J$k%9%l%C%I$N(B ID $B$b;XDj$9$k(B

:float		$B%U%#%k%?>r7o$,0lCW$7$?$H$-!"$3$N%U%#%k%?9`L\$r(B
		`navi2ch-article-sort-message-filter-rules'$B$rL5;k$7$F(B
		$B>o$K(B alist $B$N@hF,$K;}$C$F$/$k>l9g$O(B 1 ($B@5?tCM(B)$B$r;XDj$7!"(B
		$B$=$N$^$^$K$9$k>l9g$O(B 0 ($BHs@5?tCM(B)$B$r;XDj$9$k(B


$B%U%#%k%?=hM}$K$O!"J8;zNs!&%7%s%\%k!&?tCM$N$I$l$+$r;XDj$9$k!#(B

$BJ8;zNs$r;XDj$9$k$H!"%l%9$,$=$NJ8;zNs$KCV$-49$o$k!#(B

$B%U%#%k%?>r7o$r3HD%7A<0$G;XDj$7$F$$$?>l9g!"(B
$BCV498e$NJ8;zNsCf$N(B \\1$B!A(B\\9 $B$*$h$S(B \\& $B$O!"0lCW$7$?J8;zNs$KE83+$5$l$k!#(B
\\1$B!A(B\\9 $B$*$h$S(B \\& $B$N0UL#$K$D$$$F$O!"(B`replace-match'$B$r;2>H$N$3$H!#(B

$B%7%s%\%k$r;XDj$9$k$H!"%7%s%\%k$K9g$o$;$F2<5-$N=hM}$,9T$o$l$k!#(B

hide		$B%l%9$r1#$9(B
important	$B%l%9$r%V%C%/%^!<%/$KEPO?$9$k(B

$B?tCM$r;XDj$9$k$H!"%l%9$NF@E@$K$=$N?tCMJ,$NE@?t$r2C$($F!"(B
$B;D$j$N%U%#%k%?$r<B9T$9$k!#(B

$BNc$($P2<5-$NCM$r@_Dj$9$k$H!"(B
$BL>A0$K!V$U$,!W$,4^$^$l$F$$$k$H%l%9$,!V$"$\$\!<$s!W$KCV$-49$o$j!"(B
$BL>A0$K!V%[%2!W$,4^$^$l$F$$$k$H%l%9$,1#$5$l$k!#(B

'((\"$B$U$,(B\" . \"$B$"$\$\!<$s(B\")
  ((\"$B%[%2(B\" S) . hide))"
  :type (let ((plist '(set :inline t
			   :format "%v"
			   (list :tag "$BJ8;zNs0lCW$N??56$r5UE>(B"
				 :inline t
				 :format "%{%t%}\n"
				 :value '(:invert t))
			   (list :tag "$BHD$r;XDj(B"
				 :inline t
				 (const :format ""
					:value :board-id)
				 (string :tag "ID")
				 (set :inline t
				      :format "%v"
				      (list :tag "$B%9%l%C%I$b;XDj(B"
					    :inline t
					    (const :format ""
						   :value :artid)
					    (string :tag "ID"))))
			   (list :tag "$B>r7o$,0lCW$7$?$H$-$N%U%#%k%?$N0LCV(B"
				 :inline t
				 (const :format ""
					:value :float)
				 (choice :value 0
					 (const :tag "$B$=$N$^$^(B"
						:value 0)
					 (const :tag "$B@hF,$X(B"
						:value 1))))))
	  `(repeat (cons (choice :tag "$B>r7o(B"
				 (string)
				 (list :tag "$BItJ,0lCW(B"
				       :value ("" S)
				       (string)
				       (choice :tag "$BBgJ8;z$H>.J8;z$N6hJL(B"
					       (const :tag "$B$"$j(B"
						      :value S)
					       (const :tag "$B$J$7(B"
						      :value s))
				       ,plist)
				 (list :tag "$B40A40lCW(B"
				       :value ("" E)
				       (string)
				       (choice :tag "$BBgJ8;z$H>.J8;z$N6hJL(B"
					       (const :tag "$B$"$j(B"
						      :value E)
					       (const :tag "$B$J$7(B"
						      :value e))
				       ,plist)
				 (list :tag "$B$"$$$^$$0lCW(B"
				       :value ("" f)
				       (string)
				       (choice :tag "$BBgJ8;z$H>.J8;z!&$R$i$,$J$H%+%?%+%J$N6hJL(B"
					       (const :tag "$B$"$j(B"
						      :value F)
					       (const :tag "$B$J$7(B"
						      :value f))
				       ,plist)
				 (list :tag "$B@55,I=8=(B"
				       :value ("" R)
				       (regexp)
				       (choice :tag "$BBgJ8;z$H>.J8;z$N6hJL(B"
					       (const :tag "$B$"$j(B"
						      :value R)
					       (const :tag "$B$J$7(B"
						      :value r))
				       ,plist))
			 (choice :tag "$B=hM}(B"
				 (string :tag "$BCV$-49$($k(B"
					 :value "$B$"$\$\!<$s(B")
				 (const :tag "$B1#$9(B"
					:value hide)
				 (const :tag "$B%V%C%/%^!<%/$KEPO?$9$k(B"
					:value important)
				 (number :tag "$BE@?t$r2C$($k(B"
					 :value 0)))))
  :group 'navi2ch-article)

(defcustom navi2ch-article-message-filter-by-message-alist nil
  "*$B%l%9$r%U%#%k%?$9$k$?$a$N%l%9K\J8$N>r7o$H!"%U%#%k%?=hM}$N(B alist$B!#(B

$B>r7o$K$OJ8;zNs$+!"(B
\($BJ8;zNs(B $B%7%s%\%k(B ...)$B$N7A<0$N%j%9%H(B($B3HD%7A<0(B)$B$r;XDj$9$k!#(B

$BJ8;zNs$r;XDj$9$k$H!"(B
$B%l%9K\J8$,$=$NJ8;zNs$r4^$`$H$-$K%U%#%k%?=hM}$,<B9T$5$l$k!#(B

$B3HD%7A<0$r;XDj$9$k$H!"(B
$B%7%s%\%k$K9g$o$;$F2<5-$NJ}K!$G%l%9K\J8$r8!::$9$k!#(B

S,s	$BItJ,0lCW(B
E,e	$B40A40lCW(B
F,f	$B$"$$$^$$0lCW(B	($B6uGr$d2~9T$NM-L5$dB?>/$rL5;k$7!"(B
			$B$^$?A43Q$HH>3Q$r6hJL$7$J$$ItJ,0lCW(B)
R,r	$B@55,I=8=(B

$BBgJ8;z$N%7%s%\%k$r;XDj$9$k$HJ8;zNs$NBgJ8;z$H>.J8;z$r6hJL$7!"(B
$B>.J8;z$N%7%s%\%k$r;XDj$9$k$HJ8;zNs$NBgJ8;z$H>.J8;z$r6hJL$7$J$$!#(B

$B$"$$$^$$0lCW$r>.J8;z$G;XDj$7$?>l9g$O!"$R$i$,$J$H%+%?%+%J$b6hJL$7$J$$!#(B

$B%7%s%\%k$N8e$K$O%-!<%o!<%I$rDI2C$7!"(B
$BCM$K$h$C$F%U%#%k%?>r7o$r2<5-$N$h$&$KJdB-$9$k$3$H$,$G$-$k!#(B

:invert		t (non-nil)$B$r;XDj$9$k$H!"J8;zNs0lCW$N??56$r5UE>$9$k(B

:board-id	$B%U%#%k%?BP>]$H$J$kHD$N(B ID $B$r;XDj$9$k(B
:artid		$B%U%#%k%?BP>]$H$J$k%9%l%C%I$N(B ID $B$b;XDj$9$k(B

:float		$B%U%#%k%?>r7o$,0lCW$7$?$H$-!"$3$N%U%#%k%?9`L\$r(B
		`navi2ch-article-sort-message-filter-rules'$B$rL5;k$7$F(B
		$B>o$K(B alist $B$N@hF,$K;}$C$F$/$k>l9g$O(B 1 ($B@5?tCM(B)$B$r;XDj$7!"(B
		$B$=$N$^$^$K$9$k>l9g$O(B 0 ($BHs@5?tCM(B)$B$r;XDj$9$k(B


$B%U%#%k%?=hM}$K$O!"J8;zNs!&%7%s%\%k!&?tCM$N$I$l$+$r;XDj$9$k!#(B

$BJ8;zNs$r;XDj$9$k$H!"%l%9$,$=$NJ8;zNs$KCV$-49$o$k!#(B

$B%U%#%k%?>r7o$r3HD%7A<0$G;XDj$7$F$$$?>l9g!"(B
$BCV498e$NJ8;zNsCf$N(B \\1$B!A(B\\9 $B$*$h$S(B \\& $B$O!"0lCW$7$?J8;zNs$KE83+$5$l$k!#(B
\\1$B!A(B\\9 $B$*$h$S(B \\& $B$N0UL#$K$D$$$F$O!"(B`replace-match'$B$r;2>H$N$3$H!#(B

$B%7%s%\%k$r;XDj$9$k$H!"%7%s%\%k$K9g$o$;$F2<5-$N=hM}$,9T$o$l$k!#(B

hide		$B%l%9$r1#$9(B
important	$B%l%9$r%V%C%/%^!<%/$KEPO?$9$k(B

$B?tCM$r;XDj$9$k$H!"%l%9$NF@E@$K$=$N?tCMJ,$NE@?t$r2C$($F!"(B
$B;D$j$N%U%#%k%?$r<B9T$9$k!#(B

$BNc$($P2<5-$NCM$r@_Dj$9$k$H!"(B
$B%l%9K\J8$K!V$U$,!W$,4^$^$l$F$$$k$H%l%9$,!V$"$\$\!<$s!W$KCV$-49$o$j!"(B
$B%l%9K\J8$K!V%[%2!W$,4^$^$l$F$$$k$H%l%9$,1#$5$l$k!#(B

'((\"$B$U$,(B\" . \"$B$"$\$\!<$s(B\")
  ((\"$B%[%2(B\" S) . hide))"
  :type (let ((plist '(set :inline t
			   :format "%v"
			   (list :tag "$BJ8;zNs0lCW$N??56$r5UE>(B"
				 :inline t
				 :format "%{%t%}\n"
				 :value '(:invert t))
			   (list :tag "$BHD$r;XDj(B"
				 :inline t
				 (const :format ""
					:value :board-id)
				 (string :tag "ID")
				 (set :inline t
				      :format "%v"
				      (list :tag "$B%9%l%C%I$b;XDj(B"
					    :inline t
					    (const :format ""
						   :value :artid)
					    (string :tag "ID"))))
			   (list :tag "$B>r7o$,0lCW$7$?$H$-$N%U%#%k%?$N0LCV(B"
				 :inline t
				 (const :format ""
					:value :float)
				 (choice :value 0
					 (const :tag "$B$=$N$^$^(B"
						:value 0)
					 (const :tag "$B@hF,$X(B"
						:value 1))))))
	  `(repeat (cons (choice :tag "$B>r7o(B"
				 (string)
				 (list :tag "$BItJ,0lCW(B"
				       :value ("" S)
				       (string)
				       (choice :tag "$BBgJ8;z$H>.J8;z$N6hJL(B"
					       (const :tag "$B$"$j(B"
						      :value S)
					       (const :tag "$B$J$7(B"
						      :value s))
				       ,plist)
				 (list :tag "$B40A40lCW(B"
				       :value ("" E)
				       (string)
				       (choice :tag "$BBgJ8;z$H>.J8;z$N6hJL(B"
					       (const :tag "$B$"$j(B"
						      :value E)
					       (const :tag "$B$J$7(B"
						      :value e))
				       ,plist)
				 (list :tag "$B$"$$$^$$0lCW(B"
				       :value ("" f)
				       (string)
				       (choice :tag "$BBgJ8;z$H>.J8;z!&$R$i$,$J$H%+%?%+%J$N6hJL(B"
					       (const :tag "$B$"$j(B"
						      :value F)
					       (const :tag "$B$J$7(B"
						      :value f))
				       ,plist)
				 (list :tag "$B@55,I=8=(B"
				       :value ("" R)
				       (regexp)
				       (choice :tag "$BBgJ8;z$H>.J8;z$N6hJL(B"
					       (const :tag "$B$"$j(B"
						      :value R)
					       (const :tag "$B$J$7(B"
						      :value r))
				       ,plist))
			 (choice :tag "$B=hM}(B"
				 (string :tag "$BCV$-49$($k(B"
					 :value "$B$"$\$\!<$s(B")
				 (const :tag "$B1#$9(B"
					:value hide)
				 (const :tag "$B%V%C%/%^!<%/$KEPO?$9$k(B"
					:value important)
				 (number :tag "$BE@?t$r2C$($k(B"
					 :value 0)))))
  :group 'navi2ch-article)

(defcustom navi2ch-article-message-filter-by-id-alist nil
  "*$B%l%9$r%U%#%k%?$9$k$?$a$N(B ID $B$N>r7o$H!"%U%#%k%?=hM}$N(B alist$B!#(B

$B>r7o$K$OJ8;zNs$+!"(B
\($BJ8;zNs(B $B%7%s%\%k(B ...)$B$N7A<0$N%j%9%H(B($B3HD%7A<0(B)$B$r;XDj$9$k!#(B

$BJ8;zNs$r;XDj$9$k$H!"(B
ID $B$,$=$NJ8;zNs$r4^$`$H$-$K%U%#%k%?=hM}$,<B9T$5$l$k!#(B

$B3HD%7A<0$r;XDj$9$k$H!"(B
$B%7%s%\%k$K9g$o$;$F2<5-$NJ}K!$G(B ID $B$r8!::$9$k!#(B

S,s	$BItJ,0lCW(B
E,e	$B40A40lCW(B
F,f	$B$"$$$^$$0lCW(B	($B6uGr$d2~9T$NM-L5$dB?>/$rL5;k$7!"(B
			$B$^$?A43Q$HH>3Q$r6hJL$7$J$$ItJ,0lCW(B)
R,r	$B@55,I=8=(B

$BBgJ8;z$N%7%s%\%k$r;XDj$9$k$HJ8;zNs$NBgJ8;z$H>.J8;z$r6hJL$7!"(B
$B>.J8;z$N%7%s%\%k$r;XDj$9$k$HJ8;zNs$NBgJ8;z$H>.J8;z$r6hJL$7$J$$!#(B

$B$"$$$^$$0lCW$r>.J8;z$G;XDj$7$?>l9g$O!"$R$i$,$J$H%+%?%+%J$b6hJL$7$J$$!#(B

$B%7%s%\%k$N8e$K$O%-!<%o!<%I$rDI2C$7!"(B
$BCM$K$h$C$F%U%#%k%?>r7o$r2<5-$N$h$&$KJdB-$9$k$3$H$,$G$-$k!#(B

:invert		t (non-nil)$B$r;XDj$9$k$H!"J8;zNs0lCW$N??56$r5UE>$9$k(B

:board-id	$B%U%#%k%?BP>]$H$J$kHD$N(B ID $B$r;XDj$9$k(B
:artid		$B%U%#%k%?BP>]$H$J$k%9%l%C%I$N(B ID $B$b;XDj$9$k(B

:float		$B%U%#%k%?>r7o$,0lCW$7$?$H$-!"$3$N%U%#%k%?9`L\$r(B
		`navi2ch-article-sort-message-filter-rules'$B$rL5;k$7$F(B
		$B>o$K(B alist $B$N@hF,$K;}$C$F$/$k>l9g$O(B 1 ($B@5?tCM(B)$B$r;XDj$7!"(B
		$B$=$N$^$^$K$9$k>l9g$O(B 0 ($BHs@5?tCM(B)$B$r;XDj$9$k(B


$B%U%#%k%?=hM}$K$O!"J8;zNs!&%7%s%\%k!&?tCM$N$I$l$+$r;XDj$9$k!#(B

$BJ8;zNs$r;XDj$9$k$H!"%l%9$,$=$NJ8;zNs$KCV$-49$o$k!#(B

$B%U%#%k%?>r7o$r3HD%7A<0$G;XDj$7$F$$$?>l9g!"(B
$BCV498e$NJ8;zNsCf$N(B \\1$B!A(B\\9 $B$*$h$S(B \\& $B$O!"0lCW$7$?J8;zNs$KE83+$5$l$k!#(B
\\1$B!A(B\\9 $B$*$h$S(B \\& $B$N0UL#$K$D$$$F$O!"(B`replace-match'$B$r;2>H$N$3$H!#(B

$B%7%s%\%k$r;XDj$9$k$H!"%7%s%\%k$K9g$o$;$F2<5-$N=hM}$,9T$o$l$k!#(B

hide		$B%l%9$r1#$9(B
important	$B%l%9$r%V%C%/%^!<%/$KEPO?$9$k(B

$B?tCM$r;XDj$9$k$H!"%l%9$NF@E@$K$=$N?tCMJ,$NE@?t$r2C$($F!"(B
$B;D$j$N%U%#%k%?$r<B9T$9$k!#(B

$BNc$($P2<5-$NCM$r@_Dj$9$k$H!"(B
ID $B$K!V(BFUga1234$B!W$,4^$^$l$F$$$k$H%l%9$,!V$"$\$\!<$s!W$KCV$-49$o$j!"(B
ID $B$,!V(BhoGE0987$B!W$@$H%l%9$,1#$5$l$k!#(B

'((\"FUga1234\" . \"$B$"$\$\!<$s(B\")
  ((\"hoGE0987\" E) . hide))"
  :type (let ((plist '(set :inline t
			   :format "%v"
			   (list :tag "$BJ8;zNs0lCW$N??56$r5UE>(B"
				 :inline t
				 :format "%{%t%}\n"
				 :value '(:invert t))
			   (list :tag "$BHD$r;XDj(B"
				 :inline t
				 (const :format ""
					:value :board-id)
				 (string :tag "ID")
				 (set :inline t
				      :format "%v"
				      (list :tag "$B%9%l%C%I$b;XDj(B"
					    :inline t
					    (const :format ""
						   :value :artid)
					    (string :tag "ID"))))
			   (list :tag "$B>r7o$,0lCW$7$?$H$-$N%U%#%k%?$N0LCV(B"
				 :inline t
				 (const :format ""
					:value :float)
				 (choice :value 0
					 (const :tag "$B$=$N$^$^(B"
						:value 0)
					 (const :tag "$B@hF,$X(B"
						:value 1))))))
	  `(repeat (cons (choice :tag "$B>r7o(B"
				 (string)
				 (list :tag "$BItJ,0lCW(B"
				       :value ("" S)
				       (string)
				       (choice :tag "$BBgJ8;z$H>.J8;z$N6hJL(B"
					       (const :tag "$B$"$j(B"
						      :value S)
					       (const :tag "$B$J$7(B"
						      :value s))
				       ,plist)
				 (list :tag "$B40A40lCW(B"
				       :value ("" E)
				       (string)
				       (choice :tag "$BBgJ8;z$H>.J8;z$N6hJL(B"
					       (const :tag "$B$"$j(B"
						      :value E)
					       (const :tag "$B$J$7(B"
						      :value e))
				       ,plist)
				 (list :tag "$B$"$$$^$$0lCW(B"
				       :value ("" f)
				       (string)
				       (choice :tag "$BBgJ8;z$H>.J8;z!&$R$i$,$J$H%+%?%+%J$N6hJL(B"
					       (const :tag "$B$"$j(B"
						      :value F)
					       (const :tag "$B$J$7(B"
						      :value f))
				       ,plist)
				 (list :tag "$B@55,I=8=(B"
				       :value ("" R)
				       (regexp)
				       (choice :tag "$BBgJ8;z$H>.J8;z$N6hJL(B"
					       (const :tag "$B$"$j(B"
						      :value R)
					       (const :tag "$B$J$7(B"
						      :value r))
				       ,plist))
			 (choice :tag "$B=hM}(B"
				 (string :tag "$BCV$-49$($k(B"
					 :value "$B$"$\$\!<$s(B")
				 (const :tag "$B1#$9(B"
					:value hide)
				 (const :tag "$B%V%C%/%^!<%/$KEPO?$9$k(B"
					:value important)
				 (number :tag "$BE@?t$r2C$($k(B"
					 :value 0)))))
  :group 'navi2ch-article)

(defcustom navi2ch-article-message-filter-by-mail-alist nil
  "*$B%l%9$r%U%#%k%?$9$k$?$a$N%a!<%kMs$N>r7o$H!"%U%#%k%?=hM}$N(B alist$B!#(B

$B>r7o$K$OJ8;zNs$+!"(B
\($BJ8;zNs(B $B%7%s%\%k(B ...)$B$N7A<0$N%j%9%H(B($B3HD%7A<0(B)$B$r;XDj$9$k!#(B

$BJ8;zNs$r;XDj$9$k$H!"(B
$B%a!<%kMs$,$=$NJ8;zNs$r4^$`$H$-$K%U%#%k%?=hM}$,<B9T$5$l$k!#(B

$B3HD%7A<0$r;XDj$9$k$H!"(B
$B%7%s%\%k$K9g$o$;$F2<5-$NJ}K!$G%a!<%kMs$r8!::$9$k!#(B

S,s	$BItJ,0lCW(B
E,e	$B40A40lCW(B
F,f	$B$"$$$^$$0lCW(B	($B6uGr$d2~9T$NM-L5$dB?>/$rL5;k$7!"(B
			$B$^$?A43Q$HH>3Q$r6hJL$7$J$$ItJ,0lCW(B)
R,r	$B@55,I=8=(B

$BBgJ8;z$N%7%s%\%k$r;XDj$9$k$HJ8;zNs$NBgJ8;z$H>.J8;z$r6hJL$7!"(B
$B>.J8;z$N%7%s%\%k$r;XDj$9$k$HJ8;zNs$NBgJ8;z$H>.J8;z$r6hJL$7$J$$!#(B

$B$"$$$^$$0lCW$r>.J8;z$G;XDj$7$?>l9g$O!"$R$i$,$J$H%+%?%+%J$b6hJL$7$J$$!#(B

$B%7%s%\%k$N8e$K$O%-!<%o!<%I$rDI2C$7!"(B
$BCM$K$h$C$F%U%#%k%?>r7o$r2<5-$N$h$&$KJdB-$9$k$3$H$,$G$-$k!#(B

:invert		t (non-nil)$B$r;XDj$9$k$H!"J8;zNs0lCW$N??56$r5UE>$9$k(B

:board-id	$B%U%#%k%?BP>]$H$J$kHD$N(B ID $B$r;XDj$9$k(B
:artid		$B%U%#%k%?BP>]$H$J$k%9%l%C%I$N(B ID $B$b;XDj$9$k(B

:float		$B%U%#%k%?>r7o$,0lCW$7$?$H$-!"$3$N%U%#%k%?9`L\$r(B
		`navi2ch-article-sort-message-filter-rules'$B$rL5;k$7$F(B
		$B>o$K(B alist $B$N@hF,$K;}$C$F$/$k>l9g$O(B 1 ($B@5?tCM(B)$B$r;XDj$7!"(B
		$B$=$N$^$^$K$9$k>l9g$O(B 0 ($BHs@5?tCM(B)$B$r;XDj$9$k(B


$B%U%#%k%?=hM}$K$O!"J8;zNs!&%7%s%\%k!&?tCM$N$I$l$+$r;XDj$9$k!#(B

$BJ8;zNs$r;XDj$9$k$H!"%l%9$,$=$NJ8;zNs$KCV$-49$o$k!#(B

$B%U%#%k%?>r7o$r3HD%7A<0$G;XDj$7$F$$$?>l9g!"(B
$BCV498e$NJ8;zNsCf$N(B \\1$B!A(B\\9 $B$*$h$S(B \\& $B$O!"0lCW$7$?J8;zNs$KE83+$5$l$k!#(B
\\1$B!A(B\\9 $B$*$h$S(B \\& $B$N0UL#$K$D$$$F$O!"(B`replace-match'$B$r;2>H$N$3$H!#(B

$B%7%s%\%k$r;XDj$9$k$H!"%7%s%\%k$K9g$o$;$F2<5-$N=hM}$,9T$o$l$k!#(B

hide		$B%l%9$r1#$9(B
important	$B%l%9$r%V%C%/%^!<%/$KEPO?$9$k(B

$B?tCM$r;XDj$9$k$H!"%l%9$NF@E@$K$=$N?tCMJ,$NE@?t$r2C$($F!"(B
$B;D$j$N%U%#%k%?$r<B9T$9$k!#(B

$BNc$($P2<5-$NCM$r@_Dj$9$k$H!"(B
$B%a!<%kMs$K!V$U$,!W$,4^$^$l$F$$$k$H%l%9$,!V$"$\$\!<$s!W$KCV$-49$o$j!"(B
$B%a!<%kMs$K!V%[%2!W$,4^$^$l$F$$$k$H%l%9$,1#$5$l$k!#(B

'((\"$B$U$,(B\" . \"$B$"$\$\!<$s(B\")
  ((\"$B%[%2(B\" S) . hide))"
  :type (let ((plist '(set :inline t
			   :format "%v"
			   (list :tag "$BJ8;zNs0lCW$N??56$r5UE>(B"
				 :inline t
				 :format "%{%t%}\n"
				 :value '(:invert t))
			   (list :tag "$BHD$r;XDj(B"
				 :inline t
				 (const :format ""
					:value :board-id)
				 (string :tag "ID")
				 (set :inline t
				      :format "%v"
				      (list :tag "$B%9%l%C%I$b;XDj(B"
					    :inline t
					    (const :format ""
						   :value :artid)
					    (string :tag "ID"))))
			   (list :tag "$B>r7o$,0lCW$7$?$H$-$N%U%#%k%?$N0LCV(B"
				 :inline t
				 (const :format ""
					:value :float)
				 (choice :value 0
					 (const :tag "$B$=$N$^$^(B"
						:value 0)
					 (const :tag "$B@hF,$X(B"
						:value 1))))))
	  `(repeat (cons (choice :tag "$B>r7o(B"
				 (string)
				 (list :tag "$BItJ,0lCW(B"
				       :value ("" S)
				       (string)
				       (choice :tag "$BBgJ8;z$H>.J8;z$N6hJL(B"
					       (const :tag "$B$"$j(B"
						      :value S)
					       (const :tag "$B$J$7(B"
						      :value s))
				       ,plist)
				 (list :tag "$B40A40lCW(B"
				       :value ("" E)
				       (string)
				       (choice :tag "$BBgJ8;z$H>.J8;z$N6hJL(B"
					       (const :tag "$B$"$j(B"
						      :value E)
					       (const :tag "$B$J$7(B"
						      :value e))
				       ,plist)
				 (list :tag "$B$"$$$^$$0lCW(B"
				       :value ("" f)
				       (string)
				       (choice :tag "$BBgJ8;z$H>.J8;z!&$R$i$,$J$H%+%?%+%J$N6hJL(B"
					       (const :tag "$B$"$j(B"
						      :value F)
					       (const :tag "$B$J$7(B"
						      :value f))
				       ,plist)
				 (list :tag "$B@55,I=8=(B"
				       :value ("" R)
				       (regexp)
				       (choice :tag "$BBgJ8;z$H>.J8;z$N6hJL(B"
					       (const :tag "$B$"$j(B"
						      :value R)
					       (const :tag "$B$J$7(B"
						      :value r))
				       ,plist))
			 (choice :tag "$B=hM}(B"
				 (string :tag "$BCV$-49$($k(B"
					 :value "$B$"$\$\!<$s(B")
				 (const :tag "$B1#$9(B"
					:value hide)
				 (const :tag "$B%V%C%/%^!<%/$KEPO?$9$k(B"
					:value important)
				 (number :tag "$BE@?t$r2C$($k(B"
					 :value 0)))))
  :group 'navi2ch-article)

(defcustom navi2ch-article-message-filter-by-subject-alist nil
  "*$B%l%9$r%U%#%k%?$9$k$?$a$N%9%l%C%I$N%?%$%H%k$N>r7o$H!"%U%#%k%?=hM}$N(B alist$B!#(B

$B>r7o$K$OJ8;zNs$+!"(B
\($BJ8;zNs(B $B%7%s%\%k(B ...)$B$N7A<0$N%j%9%H(B($B3HD%7A<0(B)$B$r;XDj$9$k!#(B

$BJ8;zNs$r;XDj$9$k$H!"(B
$B%9%l%C%I$N%?%$%H%k$,$=$NJ8;zNs$r4^$`$H$-$K%U%#%k%?=hM}$,<B9T$5$l$k!#(B

$B3HD%7A<0$r;XDj$9$k$H!"(B
$B%7%s%\%k$K9g$o$;$F2<5-$NJ}K!$G%9%l%C%I$N%?%$%H%k$r8!::$9$k!#(B

S,s	$BItJ,0lCW(B
E,e	$B40A40lCW(B
F,f	$B$"$$$^$$0lCW(B	($B6uGr$d2~9T$NM-L5$dB?>/$rL5;k$7!"(B
			$B$^$?A43Q$HH>3Q$r6hJL$7$J$$ItJ,0lCW(B)
R,r	$B@55,I=8=(B

$BBgJ8;z$N%7%s%\%k$r;XDj$9$k$HJ8;zNs$NBgJ8;z$H>.J8;z$r6hJL$7!"(B
$B>.J8;z$N%7%s%\%k$r;XDj$9$k$HJ8;zNs$NBgJ8;z$H>.J8;z$r6hJL$7$J$$!#(B

$B$"$$$^$$0lCW$r>.J8;z$G;XDj$7$?>l9g$O!"$R$i$,$J$H%+%?%+%J$b6hJL$7$J$$!#(B

$B%7%s%\%k$N8e$K$O%-!<%o!<%I$rDI2C$7!"(B
$BCM$K$h$C$F%U%#%k%?>r7o$r2<5-$N$h$&$KJdB-$9$k$3$H$,$G$-$k!#(B

:invert		t (non-nil)$B$r;XDj$9$k$H!"J8;zNs0lCW$N??56$r5UE>$9$k(B

:board-id	$B%U%#%k%?BP>]$H$J$kHD$N(B ID $B$r;XDj$9$k(B
:artid		$B%U%#%k%?BP>]$H$J$k%9%l%C%I$N(B ID $B$b;XDj$9$k(B

:float		$B%U%#%k%?>r7o$,0lCW$7$?$H$-!"$3$N%U%#%k%?9`L\$r(B
		`navi2ch-article-sort-message-filter-rules'$B$rL5;k$7$F(B
		$B>o$K(B alist $B$N@hF,$K;}$C$F$/$k>l9g$O(B 1 ($B@5?tCM(B)$B$r;XDj$7!"(B
		$B$=$N$^$^$K$9$k>l9g$O(B 0 ($BHs@5?tCM(B)$B$r;XDj$9$k(B


$B%U%#%k%?=hM}$K$O!"J8;zNs!&%7%s%\%k!&?tCM$N$I$l$+$r;XDj$9$k!#(B

$BJ8;zNs$r;XDj$9$k$H!"%l%9$,$=$NJ8;zNs$KCV$-49$o$k!#(B

$B%U%#%k%?>r7o$r3HD%7A<0$G;XDj$7$F$$$?>l9g!"(B
$BCV498e$NJ8;zNsCf$N(B \\1$B!A(B\\9 $B$*$h$S(B \\& $B$O!"0lCW$7$?J8;zNs$KE83+$5$l$k!#(B
\\1$B!A(B\\9 $B$*$h$S(B \\& $B$N0UL#$K$D$$$F$O!"(B`replace-match'$B$r;2>H$N$3$H!#(B

$B%7%s%\%k$r;XDj$9$k$H!"%7%s%\%k$K9g$o$;$F2<5-$N=hM}$,9T$o$l$k!#(B

hide		$B%l%9$r1#$9(B
important	$B%l%9$r%V%C%/%^!<%/$KEPO?$9$k(B

$B?tCM$r;XDj$9$k$H!"%l%9$NF@E@$K$=$N?tCMJ,$NE@?t$r2C$($F!"(B
$B;D$j$N%U%#%k%?$r<B9T$9$k!#(B

$BNc$($P2<5-$NCM$r@_Dj$9$k$H!"(B
$B%9%l%C%I$N%?%$%H%k$K!V$U$,!W$,4^$^$l$F$$$k$H%l%9$NF@E@$,(B +1000 $B$5$l!"(B
$B%9%l%C%I$N%?%$%H%k$K!V%[%2!W$,4^$^$l$F$$$k$H%l%9$NF@E@$,(B -1000 $B$5$l$k!#(B

'((\"$B$U$,(B\" . 1000)
  ((\"$B%[%2(B\" S) . -1000))"
  :type (let ((plist '(set :inline t
			   :format "%v"
			   (list :tag "$BJ8;zNs0lCW$N??56$r5UE>(B"
				 :inline t
				 :format "%{%t%}\n"
				 :value '(:invert t))
			   (list :tag "$BHD$r;XDj(B"
				 :inline t
				 (const :format ""
					:value :board-id)
				 (string :tag "ID")
				 (set :inline t
				      :format "%v"
				      (list :tag "$B%9%l%C%I$b;XDj(B"
					    :inline t
					    (const :format ""
						   :value :artid)
					    (string :tag "ID"))))
			   (list :tag "$B>r7o$,0lCW$7$?$H$-$N%U%#%k%?$N0LCV(B"
				 :inline t
				 (const :format ""
					:value :float)
				 (choice :value 0
					 (const :tag "$B$=$N$^$^(B"
						:value 0)
					 (const :tag "$B@hF,$X(B"
						:value 1))))))
	  `(repeat (cons (choice :tag "$B>r7o(B"
				 (string)
				 (list :tag "$BItJ,0lCW(B"
				       :value ("" S)
				       (string)
				       (choice :tag "$BBgJ8;z$H>.J8;z$N6hJL(B"
					       (const :tag "$B$"$j(B"
						      :value S)
					       (const :tag "$B$J$7(B"
						      :value s))
				       ,plist)
				 (list :tag "$B40A40lCW(B"
				       :value ("" E)
				       (string)
				       (choice :tag "$BBgJ8;z$H>.J8;z$N6hJL(B"
					       (const :tag "$B$"$j(B"
						      :value E)
					       (const :tag "$B$J$7(B"
						      :value e))
				       ,plist)
				 (list :tag "$B$"$$$^$$0lCW(B"
				       :value ("" f)
				       (string)
				       (choice :tag "$BBgJ8;z$H>.J8;z!&$R$i$,$J$H%+%?%+%J$N6hJL(B"
					       (const :tag "$B$"$j(B"
						      :value F)
					       (const :tag "$B$J$7(B"
						      :value f))
				       ,plist)
				 (list :tag "$B@55,I=8=(B"
				       :value ("" R)
				       (regexp)
				       (choice :tag "$BBgJ8;z$H>.J8;z$N6hJL(B"
					       (const :tag "$B$"$j(B"
						      :value R)
					       (const :tag "$B$J$7(B"
						      :value r))
				       ,plist))
			 (choice :tag "$B=hM}(B"
				 (string :tag "$BCV$-49$($k(B"
					 :value "$B$"$\$\!<$s(B")
				 (const :tag "$B1#$9(B"
					:value hide)
				 (const :tag "$B%V%C%/%^!<%/$KEPO?$9$k(B"
					:value important)
				 (number :tag "$BE@?t$r2C$($k(B"
					 :value 0)))))
  :group 'navi2ch-article)

(defcustom navi2ch-article-message-filter-by-hostname-alist nil
  "*$B%l%9$r%U%#%k%?$9$k$?$a$N%[%9%HL>$N>r7o$H!"%U%#%k%?=hM}$N(B alist$B!#(B

$B>r7o$K$OJ8;zNs$+!"(B
\($BJ8;zNs(B $B%7%s%\%k(B ...)$B$N7A<0$N%j%9%H(B($B3HD%7A<0(B)$B$r;XDj$9$k!#(B

$BJ8;zNs$r;XDj$9$k$H!"(B
ID $B$,$=$NJ8;zNs$r4^$`$H$-$K%U%#%k%?=hM}$,<B9T$5$l$k!#(B

$B3HD%7A<0$r;XDj$9$k$H!"(B
$B%7%s%\%k$K9g$o$;$F2<5-$NJ}K!$G(B ID $B$r8!::$9$k!#(B

S,s	$BItJ,0lCW(B
E,e	$B40A40lCW(B
F,f	$B$"$$$^$$0lCW(B	($B6uGr$d2~9T$NM-L5$dB?>/$rL5;k$7!"(B
			$B$^$?A43Q$HH>3Q$r6hJL$7$J$$ItJ,0lCW(B)
R,r	$B@55,I=8=(B

$BBgJ8;z$N%7%s%\%k$r;XDj$9$k$HJ8;zNs$NBgJ8;z$H>.J8;z$r6hJL$7!"(B
$B>.J8;z$N%7%s%\%k$r;XDj$9$k$HJ8;zNs$NBgJ8;z$H>.J8;z$r6hJL$7$J$$!#(B

$B$"$$$^$$0lCW$r>.J8;z$G;XDj$7$?>l9g$O!"$R$i$,$J$H%+%?%+%J$b6hJL$7$J$$!#(B

$B%7%s%\%k$N8e$K$O%-!<%o!<%I$rDI2C$7!"(B
$BCM$K$h$C$F%U%#%k%?>r7o$r2<5-$N$h$&$KJdB-$9$k$3$H$,$G$-$k!#(B

:invert		t (non-nil)$B$r;XDj$9$k$H!"J8;zNs0lCW$N??56$r5UE>$9$k(B

:board-id	$B%U%#%k%?BP>]$H$J$kHD$N(B ID $B$r;XDj$9$k(B
:artid		$B%U%#%k%?BP>]$H$J$k%9%l%C%I$N(B ID $B$b;XDj$9$k(B

:float		$B%U%#%k%?>r7o$,0lCW$7$?$H$-!"$3$N%U%#%k%?9`L\$r(B
		`navi2ch-article-sort-message-filter-rules'$B$rL5;k$7$F(B
		$B>o$K(B alist $B$N@hF,$K;}$C$F$/$k>l9g$O(B 1 ($B@5?tCM(B)$B$r;XDj$7!"(B
		$B$=$N$^$^$K$9$k>l9g$O(B 0 ($BHs@5?tCM(B)$B$r;XDj$9$k(B


$B%U%#%k%?=hM}$K$O!"J8;zNs!&%7%s%\%k!&?tCM$N$I$l$+$r;XDj$9$k!#(B

$BJ8;zNs$r;XDj$9$k$H!"%l%9$,$=$NJ8;zNs$KCV$-49$o$k!#(B

$B%U%#%k%?>r7o$r3HD%7A<0$G;XDj$7$F$$$?>l9g!"(B
$BCV498e$NJ8;zNsCf$N(B \\1$B!A(B\\9 $B$*$h$S(B \\& $B$O!"0lCW$7$?J8;zNs$KE83+$5$l$k!#(B
\\1$B!A(B\\9 $B$*$h$S(B \\& $B$N0UL#$K$D$$$F$O!"(B`replace-match'$B$r;2>H$N$3$H!#(B

$B%7%s%\%k$r;XDj$9$k$H!"%7%s%\%k$K9g$o$;$F2<5-$N=hM}$,9T$o$l$k!#(B

hide		$B%l%9$r1#$9(B
important	$B%l%9$r%V%C%/%^!<%/$KEPO?$9$k(B

$B?tCM$r;XDj$9$k$H!"%l%9$NF@E@$K$=$N?tCMJ,$NE@?t$r2C$($F!"(B
$B;D$j$N%U%#%k%?$r<B9T$9$k!#(B

$BNc$($P2<5-$NCM$r@_Dj$9$k$H!"(B
$B%[%9%HL>$K!V(Bexample.jp$B!W$,4^$^$l$F$$$k$H%l%9$,!V$"$\$\!<$s!W$KCV$-49$o$j!"(B
$B%[%9%HL>$,!V(Bfoo.example.jp$B!W$,4^$^$l$F$$$k$H%l%9$,1#$5$l$k!#(B

'((\"example.jp\" . \"$B$"$\$\!<$s(B\")
  ((\"foo.example.jp\" S) . hide))"
  :type (let ((plist '(set :inline t
			   :format "%v"
			   (list :tag "$BJ8;zNs0lCW$N??56$r5UE>(B"
				 :inline t
				 :format "%{%t%}\n"
				 :value '(:invert t))
			   (list :tag "$BHD$r;XDj(B"
				 :inline t
				 (const :format ""
					:value :board-id)
				 (string :tag "ID")
				 (set :inline t
				      :format "%v"
				      (list :tag "$B%9%l%C%I$b;XDj(B"
					    :inline t
					    (const :format ""
						   :value :artid)
					    (string :tag "ID"))))
			   (list :tag "$B>r7o$,0lCW$7$?$H$-$N%U%#%k%?$N0LCV(B"
				 :inline t
				 (const :format ""
					:value :float)
				 (choice :value 0
					 (const :tag "$B$=$N$^$^(B"
						:value 0)
					 (const :tag "$B@hF,$X(B"
						:value 1))))))
	  `(repeat (cons (choice :tag "$B>r7o(B"
				 (string)
				 (list :tag "$BItJ,0lCW(B"
				       :value ("" S)
				       (string)
				       (choice :tag "$BBgJ8;z$H>.J8;z$N6hJL(B"
					       (const :tag "$B$"$j(B"
						      :value S)
					       (const :tag "$B$J$7(B"
						      :value s))
				       ,plist)
				 (list :tag "$B40A40lCW(B"
				       :value ("" E)
				       (string)
				       (choice :tag "$BBgJ8;z$H>.J8;z$N6hJL(B"
					       (const :tag "$B$"$j(B"
						      :value E)
					       (const :tag "$B$J$7(B"
						      :value e))
				       ,plist)
				 (list :tag "$B$"$$$^$$0lCW(B"
				       :value ("" f)
				       (string)
				       (choice :tag "$BBgJ8;z$H>.J8;z!&$R$i$,$J$H%+%?%+%J$N6hJL(B"
					       (const :tag "$B$"$j(B"
						      :value F)
					       (const :tag "$B$J$7(B"
						      :value f))
				       ,plist)
				 (list :tag "$B@55,I=8=(B"
				       :value ("" R)
				       (regexp)
				       (choice :tag "$BBgJ8;z$H>.J8;z$N6hJL(B"
					       (const :tag "$B$"$j(B"
						      :value R)
					       (const :tag "$B$J$7(B"
						      :value r))
				       ,plist))
			 (choice :tag "$B=hM}(B"
				 (string :tag "$BCV$-49$($k(B"
					 :value "$B$"$\$\!<$s(B")
				 (const :tag "$B1#$9(B"
					:value hide)
				 (const :tag "$B%V%C%/%^!<%/$KEPO?$9$k(B"
					:value important)
				 (number :tag "$BE@?t$r2C$($k(B"
					 :value 0)))))
  :group 'navi2ch-article)

(defcustom navi2ch-article-auto-activate-message-filter t
  "*non-nil $B$J$i!"%U%#%k%?5!G=$r%G%U%)%k%H$G(B on $B$K$9$k!#(B"
  :type 'boolean
  :group 'navi2ch-article)

(defcustom navi2ch-article-use-message-filter-cache t
  "*non-nil $B$J$i!"%U%#%k%?=hM}$G%-%c%C%7%e$rMxMQ$9$k!#(B
$B%-%c%C%7%e$O!"%U%#%k%?$N%"%s%I%%>pJs$NJ];}$b7s$M$k!#(B"
  :type 'boolean
  :group 'navi2ch-article)

(defcustom navi2ch-article-sort-message-filter-rules nil
  "*non-nil $B$J$i!">r7o$,0lCW$7$?%U%#%k%?9`L\$r(B alist $B$N@hF,$K;}$C$F$/$k!#(B

$BNc$($P!"(B`navi2ch-article-message-filter-by-name-alist'$B$r(B
$B2<5-$NCM$K@_Dj$7$F$$$F!V%[%2!W$H$$$&L>A0Ms$N%l%9$KEv$?$C$?>l9g!"(B

'((\"$B$U$,(B\" . \"$B$"$\$\!<$s(B\")
  ((\"$B%[%2(B\" S) . hide))

`navi2ch-article-message-filter-by-name-alist'$B$NCM$O(B
$B>r7o$,0lCW$7$?(B '((\"$B%[%2(B\" S) . hide) $B$,@hF,$KMh$k$h$&$KJB$S49$($i$l!"(B
$B<!$N$h$&$KJQ99$5$l$k!#(B

'(((\"$B%[%2(B\" S) . hide)
  (\"$B$U$,(B\" . \"$B$"$\$\!<$s(B\"))"
  :type 'boolean
  :group 'navi2ch-article)

(defcustom navi2ch-article-message-replace-below nil
  "*$B%U%#%k%?$K$h$C$F%l%9$rCV$-49$($k$?$a$NF@E@$N$7$-$$CM$H!"(B
$BCV$-49$($kJ8;zNs!#(B
$BF@E@$,$3$NCM$h$j>.$5$$$H%l%9$,CV$-49$o$k!#(B

$BNc$($P2<5-$NCM$r@_Dj$9$k$H!"(B
$B%l%9$NF@E@$,(B-1000$B$h$j>.$5$$$H%l%9$,!V$"$\$\!<$s!W$KCV$-49$o$k!#(B

'(-1000 . \"$B$"$\$\!<$s(B\")"
  :type '(choice (const :tag "off"
			:value nil)
		 (cons :tag "$B@_Dj$9$k(B"
		       (number :tag "$B$7$-$$CM(B"
			       :value 0)
		       (string :tag "$BCV498e(B"
			       :value "$B$"$\$\!<$s(B")))
  :group 'navi2ch-article)

(defcustom navi2ch-article-message-hide-below nil
  "*$B%U%#%k%?$K$h$C$F%l%9$r1#$9$?$a$NF@E@$N$7$-$$CM!#(B
$BF@E@$,$3$NCM$h$j>.$5$$$H%l%9$,1#$5$l$k!#(B"
  :type '(choice (const :tag "off"
			:value nil)
		 (number :tag "$B$7$-$$CM(B"
			 :value 0))
  :group 'navi2ch-article)

(defcustom navi2ch-article-message-add-important-above nil
  "*$B%U%#%k%?$K$h$C$F%l%9$r%V%C%/%^!<%/$KEPO?$9$k$?$a$NF@E@$N$7$-$$CM!#(B
$BF@E@$,$3$NCM$h$jBg$-$$$H%l%9$,%V%C%/%^!<%/$KEPO?$5$l$k!#(B"
  :type '(choice (const :tag "off"
			:value nil)
		 (number :tag "$B$7$-$$CM(B"
			 :value 0))
  :group 'navi2ch-article)

(defcustom navi2ch-article-save-info-wrapper-func nil
  "*navi2ch-article-save-info $BCf$G(B article $B$N(B wrapper $B$H$7$F;H$&4X?t!#(B"
  :type 'function
  :group 'navi2ch-article)

;;; message variables
(defcustom navi2ch-message-user-name ""
  "*$B%G%U%)%k%H$NL>A0!#(B"
  :type 'string
  :group 'navi2ch-message)

(defcustom navi2ch-message-user-name-alist nil
  "*$BHD$4$H$N%G%U%)%k%H$NL>A0$N(B alist$B!#(B

$B$?$H$($P<!$N$h$&$K@_Dj$7$F$*$/$H!"%M%C%H%o!<%/HD$G$O(B \"anonymous\"$B!"(B
$B%F%l%SHVAHHD$G$O(B \"$BL>L5$7$5$s(B\" $B$,%G%U%)%k%H$NL>A0$K$J$k!#(B
  '((\"network\" . \"anonymous\")
    (\"tv\" . \"$BL>L5$7$5$s(B\"))"
  :type '(repeat (cons (string :tag "$BHD(B  ") (string :tag "$BL>A0(B")))
  :group 'navi2ch-message)

(defcustom navi2ch-message-mail-address ""
  "*$B%G%U%)%k%H$N%a!<%k%"%I%l%9!#(B"
  :type 'string
  :group 'navi2ch-message)

(defcustom navi2ch-message-mail-address-alist nil
  "*$BHD$4$H$N%G%U%)%k%H$N%a!<%k%"%I%l%9$N(B alist$B!#(B

$B$?$H$($P<!$N$h$&$K@_Dj$7$F$*$/$H!"(B
$B%K%e!<%9B.JsHD$G$O(B \"someone@example.com\"$B!"(BUNIX $BHD$G$O(B \"sage\" $B$,(B
$B%G%U%)%k%H$N%a!<%k%"%I%l%9$K$J$k!#(B
  '((\"news\" . \"someone@example.com\")
    (\"unix\" . \"sage\"))"
  :type '(repeat (cons (string :tag "$BHD(B  ") (string :tag "$BL>A0(B")))
  :group 'navi2ch-message)

(defcustom navi2ch-message-ask-before-write nil
  "*non-nil $B$J$i!"%l%9$r=q$-;O$a$k$H$-$K3NG'%a%C%;!<%8$rI=<($9$k!#(B"
  :type '(choice (const :tag "yes-or-no-p $B$G3NG'(B" yes-or-no-p)
                 (const :tag "y-or-n-p $B$G3NG'(B" y-or-n-p)
                 (const :tag "$B3NG'$7$J$$(B" nil))
  :group 'navi2ch-message)

(defcustom navi2ch-message-ask-before-send 'y-or-n-p
  "*non-nil $B$J$i!"=q$-9~$_Aw?.$N3NG'%a%C%;!<%8$rI=<($9$k!#(B"
  :type '(choice (const :tag "yes-or-no-p $B$G3NG'(B" yes-or-no-p)
                 (const :tag "y-or-n-p $B$G3NG'(B" y-or-n-p)
                 (const :tag "$B3NG'$7$J$$(B" nil))
  :group 'navi2ch-message)

(defcustom navi2ch-message-ask-before-kill 'y-or-n-p
  "*non-nil $B$J$i!"=q$-$3$_%-%c%s%;%k$N3NG'%a%C%;!<%8$rI=<($9$k!#(B"
  :type '(choice (const :tag "yes-or-no-p $B$G3NG'(B" yes-or-no-p)
                 (const :tag "y-or-n-p $B$G3NG'(B" y-or-n-p)
                 (const :tag "$B3NG'$7$J$$(B" nil))
  :group 'navi2ch-message)

(defcustom navi2ch-message-always-pop-message nil
  "*non-nil $B$J$i!"?75,%a%C%;!<%8$r:n$k%3%^%s%I$O=q$-$+$1$N%l%9$r>o$KI|85$9$k!#(B
nil $B$J$i!"=q$-$+$1$rGK4~$7$F$$$$$+Ld$$9g$o$;$k!#(B
$B=q$-$+$1$N%a%C%;!<%8$N%P%C%U%!$,;D$C$F$$$k>l9g$K$@$1M-8z!#(B"
  :type 'boolean
  :group 'navi2ch-message)

(defcustom navi2ch-message-wait-time 3
  "*$B%l%9$rAw$C$?$"$H%9%l$r%j%m!<%I$9$k$^$G$NBT$A;~4V(B($BIC(B)$B!#(B"
  :type 'integer
  :group 'navi2ch-message)

(defcustom navi2ch-message-retry-wait-time 2
  "*$B%l%9Aw?.$r:F;n9T$9$k$H$-$NBT$A;~4V(B($BIC(B)$B!#(B"
  :type 'integer
  :group 'navi2ch-message)

(defcustom navi2ch-message-remember-user-name t
  "*non-nil $B$J$i!"Aw$C$?%l%9$NL>A0Mw$H%a!<%kMs$r3P$($F$*$/!#(B
$BF1$8%9%l$G<!$K%l%9$9$k$H$-$O!"$=$l$,%G%U%)%k%H$NL>A0$K$J$k!#(B"
  :type 'boolean
  :group 'navi2ch-message)

(defcustom navi2ch-message-cite-prefix "> "
  "*$B0zMQ$9$k$H$-$N@\F,<-!#(B"
  :type 'string
  :group 'navi2ch-message)

(defcustom navi2ch-message-trip nil
  "*trip $BMQ$NJ8;zNs!#=q$-$3$_;~$K(B From $B$N8e$m$KIU2C$5$l$k!#(B"
  :type '(choice (string :tag "trip $B$r;XDj(B")
		 (const :tag "trip $B$r;XDj$7$J$$(B" nil))
  :group 'navi2ch-message)

(defcustom navi2ch-message-aa-prefix-key "\C-c\C-a"
  "*AA $B$rF~NO$9$k0Y$N(B prefix-key$B!#(B"
  :type 'string
  :group 'navi2ch-message)

(defvar navi2ch-message-aa-default-alist
  '(("a" . "($B!-'%!.(B)")
    ("b" . "$B!3(B(`$B'%!-(B)(II(B")
    ("B" . "((($B!((I_$B'%(I_(B))(I6^86^8L^YL^Y(B")
    ("f" . "( $B!-(B_$B!5(B`)(IL0](B")
    ("e" . "($B"?'U(B`)")
    ("F" . "($B!-!<!.(B)")
    ("g" . "((I_$B'%(I_(B)(I:^Y'(B")
    ("G" . "(I6^$B(,(,(B((I_$B'%(I_(B;)$B(,(,(I?(B!")
    ("h" . "((I_$B'%(I_(B)(IJ'(B?")
    ("H" . "(;$B!-'%!.(B)(IJ'J'(B")
    ("i" . "((I%$B"O(I%(B)(I22(B!!")
    ("I" . "((I%$B#A(I%(B)(I28E2(B!!")
    ("j" . "((I%$B"O(I%(B)(I<^;8<^4]C^<@(B")
    ("k" . "(I7@$B(,(,(,(,(,(,(B((I_$B"O(I_(B)$B(,(,(,(,(,(,(B !!!!!")
    ("K" . "(I7@$B(,(B((I_$B"O(I_(B)$B(,(B( (I_$B"O(B)$B(,(B( $B!!(I_(B)$B(,(B($B!!!!(B)$B(,(B((I_(B $B!!(B)$B(,(B($B"O(I_(B )$B(,(B((I_$B"O(I_(B)$B(,(B!!!!")
    ("m" . "($B!-"O!.(B)")
    ("M" . "$B!3(B($B!-"&!.(B)(II(B")
    ("n" . "($B!1!<!1(B)$B%K%d%j%C(B")
    ("N" . "($B!-(B-`).(I!$B#o#O(B($B$J$s$G$@$m$&!)(B)")
    ("p" . "$B!J!!(I_$B'U(I_$B!K(IN_60](B")
    ("s" . "$B&2!J(I_$B'U(I_(Blll$B!K(I6^0](B")
    ("S" . "($B!-(I%$B&X(I%(B`)(I<.N^0](B")
    ("t" . "y=(I0(B( (I_$B'U(I_(B)(I%$B"h(B.$B!!(I@0](B")
    ("u" . "((I_$B'U(I_(B)(I3O0(B")
    ("U" . "(-$B!2(B-)(I3B@^(B"))
  "AA $B$rF~NO$9$k$H$-$N%-!<%P%$%s%I$H(B AA $B$N(B alist$B!#(B
`navi2ch-message-aa-alist' $B$+$iCM$,8+IU$+$i$J$$>l9g$O$3$C$A$+$iC5$9!#(B")

(defcustom navi2ch-message-aa-alist nil
  "*AA $B$rF~NO$9$k$H$-$N%-!<%P%$%s%I$H(B AA $B$N(B alist$B!#(B
$B$?$H$($P!"(B((\"Z\" . \"$B#Z(BZ$B#z(Bz...\")) $B$N$h$&$K@_Dj$9$k$H!"(BMessage Mode
$B$G(Bprefix-key ($B%G%U%)%k%H$G$O(B (C-c C-a) $B$"$H$K(B Z $B$rF~NO$9$k$H(B
$B#Z(BZ$B#z(Bz... $B$HF~NO$G$-$k!#(B
SPC$B!"(BC-l$B!"(BC-g$B!"(BC-v$B$O%j%9%HI=<($N:]$K;HMQ$5$l$k$N$G%-!<$K$O;HMQ$7$J$$$3$H!#(B"
  :type '(repeat (cons string string))
  :group 'navi2ch-message)

(defcustom navi2ch-message-cleanup-trailing-whitespace nil
  "*non-nil $B$J$i!"Aw?.$9$k%l%9$+$i9TKv$N6uGr$r<h$j=|$/!#(B"
  :type 'boolean
  :group 'navi2ch-message)

(defcustom navi2ch-message-cleanup-trailing-newline nil
  "*non-nil $B$J$i!"Aw?.$9$k%l%9$+$iKvHx$N6u9T$r<h$j=|$/!#(B"
  :type 'boolean
  :group 'navi2ch-message)

(defcustom navi2ch-message-popup-aa-width 39
  "*aa $B$N%j%9%H$rI=<($9$k:]$NI}!#(B"
  :type 'number
  :group 'navi2ch-message)

(defcustom navi2ch-message-force-sync nil
  "*non-nil $B$J$i!"%l%9$rAw?.$7$?$"$H6/@)E*$K(B sync $B$9$k!#(B"
  :type 'boolean
  :group 'navi2ch-message)

(defcustom navi2ch-message-save-sendlog nil
  "*non-nil $B$J$i!"Aw?.$7$?%l%9$N95$($r$H$k!#(B
Emacs $B$N%+%9%?%^%$%:%$%s%?!<%U%'%$%9$r;H$C$F$3$NCM$r(B non-nil $B$K$7$?>l9g!"(B
Navi2ch$B%+%F%4%j$K!VAw?.95$(!WHD$,<+F0E*$KDI2C$5$l$^$9!#(B
`navi2ch-init-file'$B$K(B
  (setq navi2ch-message-save-sendlog t)
$B$H=q$$$?>l9g$O!"$5$i$K(B
  (add-to-list 'navi2ch-list-navi2ch-category-alist
               navi2ch-message-sendlog-board)
$B$rDI2C$7!"(BNavi2ch$B%+%F%4%j$K!VAw?.95$(!WHD$rDI2C$7$F2<$5$$!#(B"
  :type 'boolean
  :group 'navi2ch-message
  :set (lambda (symbol value)
	 (when value
	   (eval-after-load "navi2ch"
	     '(add-to-list 'navi2ch-list-navi2ch-category-alist
			   navi2ch-message-sendlog-board)))
	 (set-default symbol value)))

(defcustom navi2ch-message-sendlog-subject "$BAw?.95$((B"
  "*$BAw?.$7$?%l%9$rJ]B8$9$k%9%l$N%?%$%H%k!#(B"
  :type 'string
  :group 'navi2ch-message)

(defcustom navi2ch-message-sendlog-response-limit 1000
  "*$BAw?.95$((B 1$B%9%l$"$?$j$N%l%9?t$N>e8B!#(Bnil $B$J$i$P@)8B$7$J$$!#(B"
  :type '(choice (integer :tag "$B%l%9?t$N>e8B(B")
		 (const :tag "$BL5@)8B(B" nil))
  :group 'navi2ch-message)

(defcustom navi2ch-message-sendlog-volume-format "%s (Part %s)"
  "*$BAw?.95$(%9%l$rJ,3d$9$k$H$-$N%U%)!<%^%C%H!#(B
$B:G=i$N(B %s $B$,%9%l$N%?%$%H%k$G!"(B2$BHVL\$N(B %s $B$,%9%l$NHV9f$GCV$-49$($i$l$k!#(B"
  :type 'string
  :group 'navi2ch-message)

(defcustom navi2ch-message-sendlog-message-format-function
  'navi2ch-message-sendlog-simple-message-format
  "*$BAw?.95$($N%l%9$r%U%)!<%^%C%H$9$k4X?t$r;XDj$9$k!#(B
$B0z?t$O0J2<(B:
\(MESSAGE SUBJECT URL BOARD ARTICLE)"
  :type '(choice
	  (const
	   :tag "$B%7%s%W%k$J%U%)!<%^%C%H(B"
	   :value navi2ch-message-sendlog-simple-message-format
	   :doc "Subject: $B%9%l%C%I%?%$%H%k(B\nURL: http://")
	  (const
	   :tag "$BHDL>IU$-$N%U%)!<%^%C%H(B"
	   :value navi2ch-message-sendlog-message-format-with-board-name
	   :doc "[$BHDL>(B]: $B%9%l%C%I%?%$%H%k(B\nURL: http://")
	  (function :tag "$B4X?t$r;XDj(B"))
  :group 'navi2ch-message)

;; net variables
(defcustom navi2ch-net-http-proxy
  (if (string= (getenv "HTTP_PROXY") "")
      nil
    (getenv "HTTP_PROXY"))
  "*HTTP $B%W%m%-%7$N(B URL$B!#(B"
  :type '(choice (string :tag "$B%W%m%-%7$r;XDj(B")
		 (const :tag "$B%W%m%-%7$r;H$o$J$$(B" nil))
  :group 'navi2ch-net)

(defcustom navi2ch-net-http-proxy-userid nil
  "*$B%W%m%-%7G'>Z$K;H$&%f!<%6L>!#(B"
  :type '(choice (string :tag "$B%f!<%6L>$r;XDj(B")
		 (const :tag "$B%f!<%6L>$r;H$o$J$$(B" nil))
  :group 'navi2ch-net)

(defcustom navi2ch-net-http-proxy-password nil
  "*$B%W%m%-%7G'>Z$K;H$&%Q%9%o!<%I!#(B"
  :type '(choice (string :tag "$B%Q%9%o!<%I$r;XDj(B")
		 (const :tag "$B%Q%9%o!<%I$r;H$o$J$$(B" nil))
  :group 'navi2ch-net)

(defcustom navi2ch-net-send-message-use-http-proxy t
  "*non-nil $B$J$i!"%l%9$rAw$k>l9g$J$I$G$b%W%m%-%7$r7PM3$9$k!#(B
$B$3$N%*%W%7%g%s$rM-8z$K$9$k$K$O!"(B`navi2ch-net-http-proxy' $B$r(B non-nil
$B$K@_Dj$9$k$3$H!#(B"
  :type 'boolean
  :group 'navi2ch-net)

(defcustom navi2ch-net-http-proxy-for-send-message nil
  "*$B%l%9=q$-9~$_$K;H$&(B HTTP $B%W%m%-%7$N(B URL$B!#(B
nil $B$N$H$-$O%W%m%-%7$H$7$F(B `navi2ch-net-http-proxy' $B$,;H$o$l$k!#(B
`navi2ch-net-send-message-use-http-proxy' $B$,(B non-nil $B$N$H$-$N$_M-8z!#(B"
  :type '(choice (string :tag "$B%W%m%-%7$r;XDj(B")
		 (const :tag "`navi2ch-net-http-proxy' $B$HF1$8(B" nil))
  :group 'navi2ch-net)

(defcustom navi2ch-net-http-proxy-userid-for-send-message nil
  "*$B%l%9=q$-9~$_;~$K%W%m%-%7G'>Z$K;H$&%f!<%6L>!#(B
`navi2ch-net-http-proxy-for-send-message' $B$,(B non-nil $B$N$H$-$N$_M-8z!#(B"
  :type '(choice (string :tag "$B%f!<%6L>$r;XDj(B")
		 (const :tag "$B%f!<%6L>$r;H$o$J$$(B" nil))
  :group 'navi2ch-net)

(defcustom navi2ch-net-http-proxy-password-for-send-message nil
  "*$B%l%9=q$-9~$_;~$K%W%m%-%7G'>Z$K;H$&%Q%9%o!<%I!#(B
`navi2ch-net-http-proxy-for-send-message' $B$,(B non-nil $B$N$H$-$N$_M-8z!#(B"
  :type '(choice (string :tag "$B%Q%9%o!<%I$r;XDj(B")
		 (const :tag "$B%Q%9%o!<%I$r;H$o$J$$(B" nil))
  :group 'navi2ch-net)

(defcustom navi2ch-net-force-update nil
  "*non-nil $B$J$i!"%U%!%$%k$r<hF@$9$k$^$($K99?7$NM-L5$r3NG'$7$J$/$J$k!#(B
nil $B$J$i!"99?7$5$l$F$$$J$$%U%!%$%k$NITI,MW$JE>Aw$O$7$J$$!#(B"
  :type 'boolean
  :group 'navi2ch-net)

(defcustom navi2ch-net-save-old-file-when-aborn 'ask
  "*$B$"$\!<$s$,$"$C$?$H$-85$N%U%!%$%k$rJ]B8$9$k$+!#(B
nil $B$J$iJ]B8$7$J$$(B
ask $B$J$iJ]B8$9$kA0$K<ALd$9$k(B
$B$=$l0J30$N(B non-nil $B$JCM$J$i2?$bJ9$+$:$KJ]B8$9$k!#(B"
  :type '(choice (const :tag "$B<ALd$9$k(B" ask)
		 (const :tag "$BJ9$+$:$KJ]B8(B" t)
		 (const :tag "$BJ]B8$7$J$$(B" nil))
  :group 'navi2ch-net)

(defcustom navi2ch-net-inherit-process-coding-system nil
  "*`inherit-process-coding-system' $B$N(B navi2ch $B$G$NB+G{CM!#(B"
  :type 'boolean
  :group 'navi2ch-net)

(defcustom navi2ch-net-accept-gzip t
  "*non-nil $B$J$i!"%U%!%$%k<u?.$K(B GZIP $B%(%s%3!<%G%#%s%0$r;H$&!#(B"
  :type 'boolean
  :group 'navi2ch-net)

(defcustom navi2ch-net-gunzip-program "gzip"
  "*gunzip $B$K;H$&%W%m%0%i%`!#(B"
  :type 'file
  :group 'navi2ch-net)

(defcustom navi2ch-net-gunzip-args '("-d" "-c" "-q")
  "*gunzip $B$r8F$S=P$9$H$-$N0z?t!#(B"
  :type '(repeat :tag "$B0z?t(B" string)
  :group 'navi2ch-net)

(defcustom navi2ch-net-enable-http11 nil
  "*non-nil $B$J$i!"(BHTTP/1.1 $B$r;HMQ$9$k!#(B"
  :type 'boolean
  :group 'navi2ch-net)

(defcustom navi2ch-open-network-stream-function
  #'open-network-stream
  "*open-network-stream $B$HF1Ey$J=hM}$r$9$k4X?t!#(B
`open-network-stream' ($B%G%U%)%k%H(B)$B!"(B
`navi2ch-open-network-stream-with-retry' (operation already in progress $B2sHr(B)
`navi2ch-open-network-stream-via-command' ($B30It%3%^%s%I$r;HMQ(B)
$B$J$I$r;XDj$9$k!#(B"
  :type '(choice (const :tag "Emacs $B$+$iD>@\@\B3(B"
			open-network-stream)
		 (const :tag
			"operation already in progress $BEy$N%(%i!<$,=P$k>l9g(B"
			navi2ch-open-network-stream-with-retry)
		 (const :tag "$B%3%^%s%I7PM3$G@\B3(B"
			navi2ch-open-network-stream-via-command)
		 (function :tag "$B4X?t$r;XDj(B"))
  :group 'navi2ch-net)

(defcustom navi2ch-open-network-stream-command nil
  "*$B%[%9%H$N%5!<%S%9$K@\B3$9$k%3%^%s%I!#(B
`navi2ch-open-network-stream-function' $B$,(B
`navi2ch-open-network-stream-via-command' $B$N>l9g$K;HMQ$5$l$k!#(B
$BCM$,J8;zNs$N>l9g!"$=$NJ8;zNs$H(B host service $B$r(B `format' $B$KEO$7!"$=$NJV(B
$B5QCM$r%7%'%k7PM3$G<B9T$9$k!#(B
$BCM$,4X?t$N>l9g!"(Bhost service $B$r0z?t$H$7$F8F$S=P$9!#(B
$B;XDj$7$?4X?t$NJV5QCM$,J8;zNs$N>l9g$O%7%'%k7PM3$G!"%j%9%H$N>l9g$OD>@\<B(B
$B9T$9$k!#(B

$B$?$H$($P!"(Bssh $B7PM3$G(B netcat $B$r;H$$$?$$>l9g$O0J2<$N$$$:$l$+$N$h$&$K$9$k!#(B
\"ssh somehost nc %s %s\"
\(lambda (host service)
  (format \"ssh somehost nc %s %s\" host service))
\(lambda (host service)
  (list \"ssh\" \"somehost\"
        \"nc\" (format \"%s\" host) (format \"%s\" service)))"
  :type '(choice (const :tag "$BL58z(B" nil)
		 (const :tag "Netcat $B$r;HMQ(B"
			(lambda (host service)
			  (list "nc" (format "%s" host)
				(format "%s" service))))
		 (string :tag "$BJ8;zNs$r;XDj(B")
		 (function :tag "$B4X?t$r;XDj(B"))
  :group 'navi2ch-net)

;;; update variables
(defcustom navi2ch-update-file "navi2ch-update.el"
  "*Navi2ch $B$N<+F099?7$KMxMQ$9$k%U%!%$%k$N%m!<%+%k%U%!%$%kL>!#(B"
  :type 'file
  :group 'navi2ch)

(defcustom navi2ch-update-base-url
  "http://navi2ch.sourceforge.net/autoupdate/"
  "*$B<+F099?7$9$k%U%!%$%k$,$"$k>l=j$N(B BASE URL$B!#(B"
  :type 'string
  :group 'navi2ch)

(defcustom navi2ch-update-url (concat navi2ch-update-base-url
				      (file-name-nondirectory
				       navi2ch-update-file))
  "*$B<+F099?7$KMxMQ$9$k%U%!%$%k$N(B URL$B!#(B"
  :type 'string
  :group 'navi2ch)

(defcustom navi2ch-auto-update nil
  "*non-nil $B$J$i!"5/F0;~$K(B `navi2ch-update-file' $B$r99?7$7$F<B9T$9$k!#(B
$B%U%!%$%k$,<B9T$5$l$k$N$O!"(B
 - `navi2ch-update-file' $B$,99?7$5$l$F$$$F!"(B
 - `navi2ch-pgp-verify-command-line' $B$,(B non-nil $B$N>l9g$O8!>Z2DG=$G!"(B
 - $B$=$3$GI=<($5$l$k3NG'$9$k%a%C%;!<%8$K(B yes $B$HEz$($?$H$-(B
$B$N$_!#(B

$B%d%P$$%3!<%I$,F~$C$F$$$k$H$^$:$$$N$G!"$J$k$Y$/(B pgp $B$+(B gpg $B$r%$%s%9%H!<(B
$B%k$7$F(B `navi2ch-pgp-verify-command-line' $B$r@_Dj$7$h$&!#(B"
  :type 'boolean
  :group 'navi2ch)

;;; auto modify variables
(defcustom navi2ch-auto-modify-file t
  "*$B@_Dj$r<+F0E*$KJQ99$7$FJ]B8$9$k%U%!%$%k!#(B
t $B$J$i(B `navi2ch-init-file' $B$KJ]B8$7!"(B
nil $B$J$i!"(B`customize'$B$rMxMQ$7$F(B`custom-file'$B$KJ]B8$9$k!#(B

$B$3$N%U%!%$%kC1BN$,<+F0E*$K%m!<%I$5$l$k$3$H$O$J$$$N$G!"(B
`navi2ch-init-file'$B0J30$N%U%!%$%k$r;XDj$7$?>l9g(B
\(`navi2ch-init-file'$B$r(B byte-compile $B$7$?>l9g$r4^$`(B)$B$OI,MW$K1~$8$F!"(B

\(load navi2ch-auto-modify-file)

$B$r(B`navi2ch-init-file'$B$KDI2C$9$k$J$I$NJ}K!$GL@<(E*$K%U%!%$%k$r(B
$B%m!<%I$9$k$3$H!#(B"
  :type '(choice (file :tag "$B%U%!%$%k(B")
		 (const :tag "custom-file" nil))
  :group 'navi2ch)

(defcustom navi2ch-auto-modify-truncate-list-alist nil
  "*$B%j%9%H7?JQ?t$rJ]B8$9$k$H$-$N!"JQ?tL>$H$=$N:GBgMWAG?t$N(B alist$B!#(B

$BNc$($P2<5-$NCM$r@_Dj$9$k$H!"(B
`navi2ch-article-message-filter-by-id-alist'$B$H(B
`navi2ch-article-message-filter-by-message-alist'$B$NMWAG$O!"(B
$B<+F0JQ99!&J]B8$N:]$K$=$l$>$l(B10$B8D0J2<!&(B100$B8D0J2<$K@Z$j5M$a$i$l$k!#(B

'((navi2ch-article-message-filter-by-id-alist . 10)
  (navi2ch-article-message-filter-by-message-alist . 100))"
  :type '(repeat (cons (variable :tag "$BJQ?tL>(B")
		       (integer :tag "$B:GBgMWAG?t(B")))
  :group 'navi2ch)

(defcustom navi2ch-icon-directory
  (cond ((condition-case nil
	     (progn
	       (require 'navi2ch-config)
	       navi2ch-config-icondir)
	   (error nil)))
	((fboundp 'locate-data-directory)
	 (locate-data-directory "navi2ch"))
	((let ((icons (expand-file-name "navi2ch/icons/"
					data-directory)))
	   (if (file-directory-p icons)
	       icons)))
	((let ((icons (expand-file-name "icons/"
					(file-name-directory
					 (locate-library "navi2ch")))))
	   (if (file-directory-p icons)
	       icons))))
  "* $B%"%$%3%s%U%!%$%k$,CV$+$l$?%G%#%l%/%H%j!#(Bnil $B$J$i%"%$%3%s$r;H$o$J$$!#(B"
  :type '(choice (directory :tag "directory") (const :tag "nil" nil))
  :group 'navi2ch)


;; Splash screen.
(defcustom navi2ch-splash-display-logo (and window-system
					    (or navi2ch-on-emacs21
						navi2ch-on-xemacs)
					    nil)
  "If it is non-nil, show graphic logo in the startup screen.
You can set it to a symbol `bitmap', `xbm' or `xpm' in order
to force the image format."
  :type '(radio (const :tag "Off" nil)
                (const :tag "On (any format)" t)
                (const xpm)
                (const xbm)
                (const :tag "bitmap (using BITMAP-MULE)" bitmap))
  :group 'navi2ch)

(defcustom navi2ch-display-splash-screen t
  "*Display splash screen at start time."
  :type 'boolean
  :group 'navi2ch)

(defcustom navi2ch-message-samba24-show nil
  "* non-nil $B$J$i(B $BO"B3Ej9F5,@)(B($BDL>N(BSAMBA24)$B$N7P2a;~4V%+%&%s%H%@%&%s$rI=<($9$k(B"
  :type 'boolean
  :group 'navi2ch-message)

;; Mona fonts.
(defgroup navi2ch-mona nil
  "*Navi2ch, $B%b%J!<%U%)%s%H(B

$B%b%J!<%U%)%s%H$O(B 2$B$A$c$s$M$k$N%"%9%-!<%"!<%H(B ($B0J2<(B AA) $B$r8+$k$?$a$K:n(B
$B$i$l$?%U%j!<$N%U%)%s%H$G$9!#(B

2$B$A$c$s$M$k$N%"%9%-!<%"!<%H$O$=$NB?$/$,%W%m%]!<%7%g%J%k%U%)%s%H$G$"$k(B
\$B!V(BMS P $B%4%7%C%/(B 12pt$B!W$rA[Dj$7$F$D$/$i$l$F$*$j!"(B UNIX $B$d(B Mac $B$N8GDjI}(B
$B%U%)%s%H$G8+$k$H$:$l$F$7$^$$$^$9!#%b%J!<%U%)%s%H$O%U%j!<$GG[I[$5$l$F$$(B
$B$kEl1@(B ($B$7$N$N$a(B) $B%U%)%s%H$NJ8;zI}$r(B MS P $B%4%7%C%/$K9g$o$;$?$b$N$G!"$3(B
$B$l$r;H$&$H(B Windows $B%f!<%68~$1$K:n$i$l$?(B AA $B$r%:%l$J$7$G8+$k$3$H$,$G$-(B
$B$^$9!#(B

                              (http://monafont.sourceforge.net/ $B$h$j(B)"
  :prefix "navi2ch-"
  :link '(url-link :tag "$B%b%J!<%U%)%s%H(B $B%[!<%`%Z!<%8(B"
		   "http://monafont.sourceforge.net/")
  :group 'navi2ch
  :load 'navi2ch-mona)

;; folder icons. filename relative to navi2ch-icon-directory
(defvar navi2ch-online-icon "plugged.xpm"
  "*Icon file for online state.")
(defvar navi2ch-offline-icon "unplugged.xpm"
  "*Icon file for offline state.")

;;; hooks
(defvar navi2ch-hook nil)
(defvar navi2ch-exit-hook nil)
(defvar navi2ch-save-status-hook nil)
(defvar navi2ch-load-status-hook nil)
(defvar navi2ch-before-startup-hook nil)
(defvar navi2ch-after-startup-hook nil)
(defvar navi2ch-kill-emacs-hook nil)
(defvar navi2ch-list-mode-hook nil)
(defvar navi2ch-list-exit-hook nil)
(defvar navi2ch-list-after-sync-hook nil)
(defvar navi2ch-list-get-category-list-hook nil)
(defvar navi2ch-board-mode-hook nil)
(defvar navi2ch-board-exit-hook nil)
(defvar navi2ch-board-before-sync-hook nil)
(defvar navi2ch-board-after-sync-hook nil)
(defvar navi2ch-board-select-board-hook nil)
(defvar navi2ch-board-get-subject-list-hook nil)
(defvar navi2ch-article-mode-hook nil)
(defvar navi2ch-article-exit-hook nil)
(defvar navi2ch-article-before-sync-hook nil)
(defvar navi2ch-article-after-sync-hook nil)
(defvar navi2ch-article-arrange-message-hook nil)
(defvar navi2ch-article-get-message-list-hook nil)
(defvar navi2ch-article-next-message-hook nil)
(defvar navi2ch-article-previous-message-hook nil)
(defvar navi2ch-article-hide-message-hook nil)
(defvar navi2ch-article-cancel-hide-message-hook nil)
(defvar navi2ch-article-add-important-message-hook nil)
(defvar navi2ch-article-delete-important-message-hook nil)
(defvar navi2ch-bookmark-mode-hook nil)
(defvar navi2ch-bookmark-exit-hook nil)
(defvar navi2ch-articles-mode-hook nil)
(defvar navi2ch-articles-exit-hook nil)
(defvar navi2ch-history-mode-hook nil)
(defvar navi2ch-history-exit-hook nil)
(defvar navi2ch-search-mode-hook nil)
(defvar navi2ch-search-exit-hook nil)
(defvar navi2ch-message-mode-hook nil)
(defvar navi2ch-message-exit-hook nil)
(defvar navi2ch-message-before-send-hook nil)
(defvar navi2ch-message-after-send-hook nil)
(defvar navi2ch-message-setup-message-hook nil)
(defvar navi2ch-message-setup-sage-message-hook nil)
(defvar navi2ch-bm-mode-hook nil)
(defvar navi2ch-bm-select-board-hook nil)
(defvar navi2ch-bm-exit-hook nil)
(defvar navi2ch-popup-article-mode-hook nil)
(defvar navi2ch-popup-article-exit-hook nil)
(defvar navi2ch-head-mode-hook nil)
(defvar navi2ch-head-exit-hook nil)
(defvar navi2ch-mona-setup-hook nil)
(defvar navi2ch-mona-undo-setup-hook nil)
(defvar navi2ch-directory-mode-hook nil)
(defvar navi2ch-directory-exit-hook nil)
(defvar navi2ch-auto-modify-save-hook nil)

;; load hooks
(defvar navi2ch-article-load-hook nil)
(defvar navi2ch-articles-load-hook nil)
(defvar navi2ch-board-misc-load-hook nil)
(defvar navi2ch-board-load-hook nil)
(defvar navi2ch-bookmark-load-hook nil)
(defvar navi2ch-face-load-hook nil)
(defvar navi2ch-head-load-hook nil)
(defvar navi2ch-history-load-hook nil)
(defvar navi2ch-list-load-hook nil)
(defvar navi2ch-message-load-hook nil)
(defvar navi2ch-mona-load-hook nil)
(defvar navi2ch-net-load-hook nil)
(defvar navi2ch-popup-article-load-hook nil)
(defvar navi2ch-search-load-hook nil)
(defvar navi2ch-util-load-hook nil)
(defvar navi2ch-vars-load-hook nil)
(defvar navi2ch-load-hook nil)
(defvar navi2ch-directory-load-hook nil)

;;; errors symbols
(put 'navi2ch-update-failed 'error-conditions '(error navi2ch-errors navi2ch-update-failed))

;;; global keybindings
;; $BJL$N>l=j$NJ}$,$$$$$s$+$J!#(B
(defvar navi2ch-global-map nil
  "navi2ch $B$N$I$N%b!<%I$G$b;H$($k(B keymap$B!#(B")
(unless navi2ch-global-map
  (let ((map (make-sparse-keymap)))
    (define-key map "\C-x\C-e" 'navi2ch-disabled-key) ; Navi2ch $BFb$G$OL58z$K(B
    (define-key map "\C-c\C-f" 'navi2ch-find-file)
    ;; (define-key map "\C-c\C-g" 'navi2ch-list-goto-board)
    (define-key map "\C-c\C-t" 'navi2ch-toggle-offline)
    (define-key map "\C-c\C-u" 'navi2ch-goto-url)
    (define-key map "\C-c\C-v" 'navi2ch-version)
    ;; (define-key map "\C-c1" 'navi2ch-one-pane)
    ;; (define-key map "\C-c2" 'navi2ch-two-pane)
    ;; (define-key map "\C-c3" 'navi2ch-three-pane)
    (define-key map "\C-c\C-o" 'navi2ch-message-jump-to-message-buffer)
    (define-key map "\C-c\C-n" 'navi2ch-article-forward-sticky-buffer)
    (define-key map "\C-c\C-p" 'navi2ch-article-backward-sticky-buffer)
    (define-key map "\C-c\C-l" 'navi2ch-be2ch-toggle-login)
    (setq navi2ch-global-map map)))

(defvar navi2ch-global-view-map nil
  "navi2ch $B$N(B message $B%b!<%I0J30$G;H$($k(B keymap$B!#(B")
(unless navi2ch-global-view-map
  (let ((map (make-sparse-keymap)))
    (set-keymap-parent map navi2ch-global-map)
    (suppress-keymap map t)
    (define-key map "1" 'navi2ch-one-pane)
    (define-key map "2" 'navi2ch-two-pane)
    (define-key map "3" 'navi2ch-three-pane)
    (define-key map "<" 'beginning-of-buffer)
    (define-key map ">" 'navi2ch-end-of-buffer)
    (define-key map "B" 'navi2ch-bookmark-goto-bookmark)
    (define-key map "g" 'navi2ch-list-goto-board)
    (define-key map "G" 'navi2ch-list-goto-board)
    (define-key map "n" 'next-line)
    (define-key map "p" 'previous-line)
    (define-key map "t" 'navi2ch-toggle-offline)
    (define-key map "V" 'navi2ch-version)
    (define-key map "\C-x\C-s" 'navi2ch-save-status)
    (setq navi2ch-global-view-map map)))

(run-hooks 'navi2ch-vars-load-hook)
;;; navi2ch-vars.el ends here

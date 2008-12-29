;;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

(add-to-load-path "~/.emacs.d/elisp/color-theme/")
(require 'color-theme)
(color-theme-initialize)

(defun my-color-theme ()
  "My color theme: Wheat on black."
  (interactive)
  (color-theme-install
   '(color-theme-billw
     ((foreground-color . "wheat")
      (background-color . "gray20")
      (mouse-color . "black")
      (cursor-color . "wheat")
      (border-color . "black")
      (background-mode . dark))
     (default ((t (nil))))
     (modeline ((t (:foreground "black" :background "wheat"))))
     (modeline-buffer-id ((t (:foreground "black" :background "wheat"))))
     (modeline-mousable ((t (:foreground "black" :background "wheat"))))
     (modeline-mousable-minor-mode ((t (:foreground "black" :background "wheat"))))
     (highlight ((t (:foreground "wheat" :background "darkslategray"))))
     (bold ((t (:bold t))))
     (italic ((t (:italic t))))
     (bold-italic ((t (:bold t :italic t))))
     (region ((t (:background "dimgray"))))
     (secondary-selection ((t (:background "deepskyblue4"))))
     (underline ((t (:underline t))))
     (info-node ((t (:foreground "yellow" :bold t :italic t))))
     (info-menu-5 ((t (:underline t))))
     (info-xref ((t (:foreground "yellow" :bold t))))
     (diary-face ((t (:foreground "orange"))))
     (calendar-today-face ((t (:underline t))))
     (holiday-face ((t (:background "red"))))
     (show-paren-match-face ((t (:background "deepskyblue4"))))
     (show-paren-mismatch-face ((t (:foreground "wheat" :background "red"))))
     (font-lock-comment-face ((t (:foreground "gold"))))
     (font-lock-string-face ((t (:foreground "orange"))))
     (font-lock-keyword-face ((t (:foreground "cyan1"))))
     (font-lock-builtin-face ((t (:foreground "LightSteelBlue"))))
     (font-lock-function-name-face ((t (:foreground "mediumspringgreen"))))
     (font-lock-variable-name-face ((t (:foreground "light salmon"))))
     (font-lock-type-face ((t (:foreground "yellow1"))))
     (font-lock-constant-face ((t (:foreground "salmon"))))
     (font-lock-warning-face ((t (:foreground "gold" :bold t))))
     (blank-space-face ((t (:background "LightGray"))))
     (blank-tab-face ((t (:foreground "black" :background "cornsilk"))))
     (highline-face ((t (:background "gray35"))))
     (eshell-ls-directory-face ((t (:foreground "green" :bold t))))
     (eshell-ls-symlink-face ((t (:foreground "Cyan" :bold t))))
     (eshell-ls-executable-face ((t (:foreground "orange" :bold t))))
     (eshell-ls-readonly-face ((t (:foreground "gray"))))
     (eshell-ls-unreadable-face ((t (:foreground "DarkGrey"))))
     (eshell-ls-special-face ((t (:foreground "Magenta" :bold t))))
     (eshell-ls-missing-face ((t (:foreground "Red" :bold t))))
     (eshell-ls-archive-face ((t (:foreground "Orchid" :bold t))))
     (eshell-ls-backup-face ((t (:foreground "LightSalmon"))))
     (eshell-ls-product-face ((t (:foreground "LightSalmon"))))
     (eshell-ls-clutter-face ((t (:foreground "blue" :bold t))))
     (sgml-start-tag-face ((t (:foreground "mediumspringgreen"))))
     (custom-button-face ((t (:foreground "wheat"))))
     (sgml-ignored-face ((t (:foreground "gray20" :background "gray60"))))
     (sgml-doctype-face ((t (:foreground "orange"))))
     (sgml-sgml-face ((t (:foreground "yellow"))))
     (vc-annotate-face-0046FF ((t (:foreground "wheat" :background "black"))))
     (custom-documentation-face ((t (:foreground "wheat"))))
     (sgml-end-tag-face ((t (:foreground "greenyellow"))))
     (linemenu-face ((t (:background "gray30"))))
     (sgml-entity-face ((t (:foreground "gold"))))
     (message-header-to-face ((t (:foreground "floral wheat" :bold t))))
     (message-header-cc-face ((t (:foreground "ivory"))))
     (message-header-subject-face ((t (:foreground "papaya whip" :bold t))))
     (message-header-newsgroups-face ((t (:foreground "lavender blush" :bold t :italic t))))
     (message-header-other-face ((t (:foreground "pale turquoise"))))
     (message-header-name-face ((t (:foreground "light sky blue"))))
     (message-header-xheader-face ((t (:foreground "blue"))))
     (message-separator-face ((t (:foreground "sandy brown"))))
     (message-cited-text-face ((t (:foreground "plum1"))))
     (message-mml-face ((t (:foreground "ForestGreen"))))
     (gnus-group-news-1-face ((t (:foreground "wheat" :bold t))))
     (gnus-group-news-1-empty-face ((t (:foreground "wheat"))))
     (gnus-group-news-2-face ((t (:foreground "lightcyan" :bold t))))
     (gnus-group-news-2-empty-face ((t (:foreground "lightcyan"))))
     (gnus-group-news-3-face ((t (:foreground "tan" :bold t))))
     (gnus-group-news-3-empty-face ((t (:foreground "tan"))))
     (gnus-group-news-4-face ((t (:foreground "wheat" :bold t))))
     (gnus-group-news-4-empty-face ((t (:foreground "wheat"))))
     (gnus-group-news-5-face ((t (:foreground "wheat" :bold t))))
     (gnus-group-news-5-empty-face ((t (:foreground "wheat"))))
     (gnus-group-news-6-face ((t (:foreground "tan" :bold t))))
     (gnus-group-news-6-empty-face ((t (:foreground "tan"))))
     (gnus-group-news-low-face ((t (:foreground "DarkTurquoise" :bold t))))
     (gnus-group-news-low-empty-face ((t (:foreground "DarkTurquoise"))))
     (gnus-group-mail-1-face ((t (:foreground "wheat" :bold t))))
     (gnus-group-mail-1-empty-face ((t (:foreground "gray80"))))
     (gnus-group-mail-2-face ((t (:foreground "lightcyan" :bold t))))
     (gnus-group-mail-2-empty-face ((t (:foreground "lightcyan"))))
     (gnus-group-mail-3-face ((t (:foreground "tan" :bold t))))
     (gnus-group-mail-3-empty-face ((t (:foreground "tan"))))
     (gnus-group-mail-low-face ((t (:foreground "aquamarine4" :bold t))))
     (gnus-group-mail-low-empty-face ((t (:foreground "aquamarine4"))))
     (gnus-summary-selected-face ((t (:background "deepskyblue4" :underline t))))
     (gnus-summary-cancelled-face ((t (:foreground "black" :background "gray"))))
     (gnus-summary-high-ticked-face ((t (:foreground "gray70" :bold t))))
     (gnus-summary-low-ticked-face ((t (:foreground "gray70" :bold t))))
     (gnus-summary-normal-ticked-face ((t (:foreground "gray70" :bold t))))
     (gnus-summary-high-ancient-face ((t (:foreground "SkyBlue" :bold t))))
     (gnus-summary-low-ancient-face ((t (:foreground "SkyBlue" :italic t))))
     (gnus-summary-normal-ancient-face ((t (:foreground "SkyBlue"))))
     (gnus-summary-high-unread-face ((t (:bold t))))
     (gnus-summary-low-unread-face ((t (:italic t))))
     (gnus-summary-normal-unread-face ((t (nil))))
     (gnus-summary-high-read-face ((t (:foreground "PaleGreen" :bold t))))
     (gnus-summary-low-read-face ((t (:foreground "PaleGreen" :italic t))))
     (gnus-summary-normal-read-face ((t (:foreground "PaleGreen"))))
     (gnus-splash-face ((t (:foreground "gold"))))
     (font-latex-bold-face ((t (nil))))
     (font-latex-italic-face ((t (nil))))
     (font-latex-math-face ((t (nil))))
     (font-latex-sedate-face ((t (:foreground "Gray85"))))
     (font-latex-string-face ((t (:foreground "orange"))))
     (font-latex-warning-face ((t (:foreground "gold"))))
     (widget-documentation-face ((t (:foreground "lime green"))))
     (widget-button-face ((t (:bold t))))
     (widget-field-face ((t (:background "gray20"))))
     (widget-single-line-field-face ((t (:background "gray20"))))
     (widget-inactive-face ((t (:foreground "wheat"))))
     (widget-button-pressed-face ((t (:foreground "red"))))
     (custom-invalid-face ((t (:foreground "yellow" :background "red"))))
     (custom-rogue-face ((t (:foreground "pink" :background "black"))))
     (custom-modified-face ((t (:foreground "wheat" :background "blue"))))
     (custom-set-face ((t (:foreground "blue"))))
     (custom-changed-face ((t (:foreground "wheat" :background "skyblue"))))
     (custom-saved-face ((t (:underline t))))
     (custom-state-face ((t (:foreground "light green"))))
     (custom-variable-tag-face ((t (:foreground "skyblue" :underline t))))
     (custom-variable-button-face ((t (:bold t :underline t))))
     (custom-face-tag-face ((t (:foreground "wheat" :underline t))))
     (custom-group-tag-face-1 ((t (:foreground "pink" :underline t))))
     (custom-group-tag-face ((t (:foreground "skyblue" :underline t))))
     (swbuff-current-buffer-face ((t (:foreground "red" :bold t))))
     (ediff-current-diff-face-A ((t (:foreground "firebrick" :background "pale green"))))
     (ediff-current-diff-face-B ((t (:foreground "DarkOrchid" :background "Yellow"))))
     (ediff-current-diff-face-C ((t (:foreground "wheat" :background "indianred"))))
     (ediff-current-diff-face-Ancestor ((t (:foreground "Black" :background "VioletRed"))))
     (ediff-fine-diff-face-A ((t (:foreground "Navy" :background "sky blue"))))
     (ediff-fine-diff-face-B ((t (:foreground "Black" :background "cyan"))))
     (ediff-fine-diff-face-C ((t (:foreground "Black" :background "Turquoise"))))
     (ediff-fine-diff-face-Ancestor ((t (:foreground "Black" :background "Green"))))
     (ediff-even-diff-face-A ((t (:foreground "Black" :background "light grey"))))
     (ediff-even-diff-face-B ((t (:foreground "Wheat" :background "Grey"))))
     (ediff-even-diff-face-C ((t (:foreground "Black" :background "light grey"))))
     (ediff-even-diff-face-Ancestor ((t (:foreground "Wheat" :background "Grey"))))
     (ediff-odd-diff-face-A ((t (:foreground "Wheat" :background "Grey"))))
     (ediff-odd-diff-face-B ((t (:foreground "Black" :background "light grey"))))
     (ediff-odd-diff-face-C ((t (:foreground "Wheat" :background "Grey"))))
     (ediff-odd-diff-face-Ancestor ((t (:foreground "Black" :background "light grey"))))
     (gnus-emphasis-bold ((t (:bold t))))
     (gnus-emphasis-italic ((t (:italic t))))
     (gnus-emphasis-underline ((t (:foreground "wheat" :background "goldenrod4"))))
     (gnus-emphasis-underline-bold ((t (:foreground "black" :background "yellow" :bold t :underline t))))
     (gnus-emphasis-underline-italic ((t (:foreground "black" :background "yellow" :italic t :underline t))))
     (gnus-emphasis-bold-italic ((t (:bold t :italic t))))
     (gnus-emphasis-underline-bold-italic ((t (:foreground "black" :background "yellow" :bold t :italic t :underline t))))
     (gnus-emphasis-highlight-words ((t (:foreground "yellow" :background "black"))))
     (gnus-signature-face ((t (:italic t))))
     (gnus-header-from-face ((t (:foreground "wheat"))))
     (gnus-header-subject-face ((t (:foreground "wheat" :bold t))))
     (gnus-header-newsgroups-face ((t (:foreground "wheat" :italic t))))
     (gnus-header-name-face ((t (:foreground "wheat"))))
     (gnus-header-content-face ((t (:foreground "tan" :italic t))))
     (gnus-filterhist-face-1 ((t (nil))))
     (gnus-splash ((t (:foreground "Brown"))))
     (gnus-cite-attribution-face ((t (:italic t))))
     (gnus-cite-face-1 ((t (:foreground "light blue"))))
     (gnus-cite-face-2 ((t (:foreground "light cyan"))))
     (gnus-cite-face-3 ((t (:foreground "light yellow"))))
     (gnus-cite-face-4 ((t (:foreground "light pink"))))
     (gnus-cite-face-5 ((t (:foreground "pale green"))))
     (gnus-cite-face-6 ((t (:foreground "beige"))))
     (gnus-cite-face-7 ((t (:foreground "orange"))))
     (gnus-cite-face-8 ((t (:foreground "magenta"))))
     (gnus-cite-face-9 ((t (:foreground "violet"))))
     (gnus-cite-face-10 ((t (:foreground "medium purple"))))
     (gnus-cite-face-11 ((t (:foreground "turquoise")))))))
(my-color-theme)

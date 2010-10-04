;;; init-font.el

(when (>= emacs-major-version 23)
  (let ((font (concat "Osaka－等幅-" (if (eq system-type 'darwin) "9" "11"))))
    (add-to-list 'default-frame-alist `(font . ,font))
    (set-default-font font)
    (set-fontset-font "fontset-default" 'japanese-jisx0208 `(,font . "unicode-bmp"))))

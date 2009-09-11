;;; init-font.el

(when (>= emacs-major-version 23)
  (add-to-list 'default-frame-alist
               '(font . "Osaka－等幅-9"))
  (set-default-font "Osaka－等幅-9")
  (set-fontset-font "fontset-default"
                    'japanese-jisx0208
                    '("Osaka－等幅-9" . "unicode-bmp")))
;(set-default-font "-*-fixed-medium-r-normal--14-*-*-*-*-*-*-*")
(set-default-font "-apple-Osaka－等幅-normal-normal-normal-*-9-*-*-*-d-0-iso10646-1")

;; Bug for emacs-snapshot-gtk with Ubuntu 8.10
;; https://bugs.launchpad.net/ubuntu/+source/emacs-snapshot/+bug/291399
(set-frame-parameter nil 'font-backend '(xft x))

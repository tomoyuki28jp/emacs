;;; init-font.el

(when (>= emacs-major-version 23)
  (add-to-list 'default-frame-alist
               '(font . "Bitstream Vera Sans Mono-9"))
  (set-default-font "Bitstream Vera Sans Mono-9")
  (set-fontset-font "fontset-default"
                    'japanese-jisx0208
                    '("VL Gothic" . "unicode-bmp")))
(set-default-font "-*-fixed-medium-r-normal--14-*-*-*-*-*-*-*")

;; Bug for emacs-snapshot-gtk with Ubuntu 8.10
;; https://bugs.launchpad.net/ubuntu/+source/emacs-snapshot/+bug/291399
(set-frame-parameter nil 'font-backend '(xft x))

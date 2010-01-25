;;; init-rails.el
;(require 'ido)
;(ido-mode t)

(add-to-load-path "~/.emacs.d/elisp/rinari/")
(require 'rinari)

(add-to-load-path "~/.emacs.d/elisp/rhtml/")
(require 'rhtml-mode)
(add-hook 'rhtml-mode-hook
    (lambda () (rinari-launch)))


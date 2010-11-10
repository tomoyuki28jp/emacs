;;; init-rails.el

(add-to-load-path "~/.emacs.d/elisp/rinari/")
(require 'rinari)

(add-to-load-path "~/.emacs.d/elisp/rhtml/")
(require 'rhtml-mode)
(add-hook 'rhtml-mode-hook
    (lambda ()
      (rinari-launch)
      (setq indent-tabs-mode nil tab-width 4)))

(require 'autotest)

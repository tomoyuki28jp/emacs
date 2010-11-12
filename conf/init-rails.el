;;; init-rails.el

(add-to-load-path "~/.emacs.d/elisp/rinari/")
(require 'rinari)

(add-to-load-path "~/.emacs.d/elisp/rhtml/")
(require 'rhtml-mode)
(add-hook 'rhtml-mode-hook
    (lambda ()
      (rinari-launch)
      (setq indent-tabs-mode nil tab-width 4)))

(add-to-load-path "~/.emacs.d/elisp/autotest/")
(require 'autotest)
(setq autotest-use-spork t)
(setq autotest-default-directory "/home/tomo/tamacy/")

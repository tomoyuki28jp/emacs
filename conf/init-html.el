;;; init-html.el

(load "~/.emacs.d/elisp/nxhtml/autostart.el")
(setq nxhtml-mode-hook
      '(lambda () (setq-default
                   tab-width 4
                   indent-tabs-mode nil)))

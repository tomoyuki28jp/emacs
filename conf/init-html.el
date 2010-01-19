;;; init-html.el

(load "~/.emacs.d/elisp/nxhtml/autostart.el")
(setq nxhtml-mode-hook
      '(lambda () (setq-default
                   tab-width 4
                   indent-tabs-mode nil)))

(custom-set-faces
 '(mumamo-background-chunk-major ((t (:background "dark"))))
 '(mumamo-background-chunk-submode ((t (:background "dark"))))
 '(mumamo-background-chunk-submode1 ((t (:background "dark"))))
 '(mumamo-background-chunk-submode2 ((t (:background "dark"))))
 '(mumamo-background-chunk-submode3 ((t (:background "dark"))))
 '(mumamo-background-chunk-submode4 ((t (:background "dark")))))

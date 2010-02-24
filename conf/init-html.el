;;; init-html.el

(add-hook 'nxhtml-mode-hook
      '(lambda () (setq indent-tabs-mode nil tab-width 4)))

(unless (eq system-type 'darwin)
  (custom-set-faces
   '(mumamo-background-chunk-major    ((t (:background "dark"))))
   '(mumamo-background-chunk-submode  ((t (:background "dark"))))
   '(mumamo-background-chunk-submode1 ((t (:background "dark"))))
   '(mumamo-background-chunk-submode2 ((t (:background "dark"))))
   '(mumamo-background-chunk-submode3 ((t (:background "dark"))))
   '(mumamo-background-chunk-submode4 ((t (:background "dark"))))))

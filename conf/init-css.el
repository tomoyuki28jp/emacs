;;; init-css.el

(require 'css-mode)
(setq css-indent-offset 2)
(setq cssm-newline-before-closing-bracket t)
(setq cssm-indent-function #'cssm-c-style-indenter)
(setq cssm-mirror-mode t)

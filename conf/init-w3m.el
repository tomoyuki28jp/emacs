;;; init-w3m.el

(add-to-load-path "~/.emacs.d/elisp/emacs-w3m")
(require 'w3m)
(setq w3m-default-display-inline-images t)
(setq browse-url-browser-function 'w3m-browse-url)
(setq w3m-use-cookies t)
;(setq w3m-pop-up-frames t)
;(setq w3m-select-buffer-horizontal-window t)

(add-hook 'w3m-mode-hook
          (lambda () (local-set-key "\C-t" 'other-window)))

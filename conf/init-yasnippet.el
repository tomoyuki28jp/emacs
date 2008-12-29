;;; init-yasnippet.el

(require 'yasnippet)
;(setq yas/trigger-key (kbd "SPC"))
;(setq yas/next-field-key (kbd "TAB"))
(setq anything-c-yas-space-match-any-greedy t)
(yas/initialize)
(yas/load-directory "~/.emacs.d/elisp/snippets/")

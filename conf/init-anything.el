;;; init-anything.el

(add-to-load-path "~/.emacs.d/elisp/anything/")

(require 'recentf-ext)
;(require 'anything)
;(require 'anything-config)
(require 'anything-startup)
;(require 'anything-match-plugin)

(define-key anything-map "\C-\M-v" 'anything-scroll-other-window)
(define-key anything-map "\C-\M-y" 'anything-scroll-other-window-down)
(define-key anything-map "\C-z" 'anything-execute-persistent-action)
(global-set-key "\C-xb" 'anything)

(setq anything-c-adaptive-history-file
      "~/.emacs.d/history/anything-c-adaptive-history")

(setq anything-sources
      (list anything-c-source-buffers
            anything-c-source-file-name-history
            anything-c-source-files-in-current-dir
            anything-c-source-recentf
            anything-c-source-locate
            anything-c-source-emacs-commands))

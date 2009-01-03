;;; init-tramp.el

(require 'tramp)
(setq tramp-default-method "ssh")
(setq tramp-auto-save-directory "/tmp")

(defun tramp-file-p ()
  (string-match "^/ssh:" (or buffer-file-name "")))

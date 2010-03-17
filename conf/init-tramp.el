;;; init-tramp.el

(when (eq system-type 'darwin)
  (add-to-load-path "~/.emacs.d/elisp/tramp-2.1.9/lisp"))
(require 'tramp)
(setq tramp-default-method "ssh")
(setq tramp-auto-save-directory "/tmp")
(setq tramp-shell-prompt-pattern "^.*[#$%>] *")

(setq tramp-methods
      (cons
       '("my-sudo" (tramp-login-program "env SHELL=/bin/sh sudo")
         (tramp-login-args (("-u" "%u") ("-s") ("-H") ("-p" "Password:")))
         (tramp-remote-sh "/bin/sh")
         (tramp-copy-program nil)
         (tramp-copy-args nil)
         (tramp-copy-keep-date nil)
         (tramp-password-end-of-line nil))
       tramp-methods))

(defun tramp-file-p ()
  (string-match "^/ssh:" (or buffer-file-name "")))

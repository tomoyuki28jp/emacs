;;; init-migemo.el

(when (eq system-type 'darwin)
  (add-to-load-path "/Applications/Emacs.app/Contents/Resources/share/emacs/site-lisp/")
  (setq migemo-command "migemo")
  (setq migemo-options '("-t" "emacs"))
  (setq migemo-dictionary "/Applications/Emacs.app/Contents/Resources/share/migemo/migemo-dict")
  (setq migemo-user-dictionary nil)
  (setq migemo-regex-dictionary nil)
  (setenv "RUBYLIB" "/Applications/Emacs.app/Contents/Resources/lib/ruby/site_ruby/"))

(require 'migemo)

; turn off migemo when emacs starts
(migemo-toggle-isearch-enable)

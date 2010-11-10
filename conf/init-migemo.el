;;; init-migemo.el

(if (progn
      (eq system-type 'darwin)
      (add-to-load-path "/Applications/Emacs.app/Contents/Resources/share/emacs/site-lisp/")
      (setq migemo-command "migemo")
      (setq migemo-options '("-t" "emacs"))
      (setq migemo-dictionary "/Applications/Emacs.app/Contents/Resources/share/migemo/migemo-dict")
      (setq migemo-user-dictionary nil)
      (setq migemo-regex-dictionary nil)
      (setenv "RUBYLIB" "/Applications/Emacs.app/Contents/Resources/lib/ruby/site_ruby/")
      (require 'migemo))
    (progn
      (setq migemo-command "cmigemo")
      (setq migemo-options '("-q" "--emacs"))
      (setq migemo-dictionary "/usr/local/share/migemo/utf-8/migemo-dict")
      (setq migemo-user-dictionary nil)
      (setq migemo-regex-dictionary nil)
      (setq migemo-coding-system 'utf-8-unix)
      (load-library "migemo")
      (migemo-init)))

(setq migemo-isearch-enable-p nil)

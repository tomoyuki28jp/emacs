;;; init-ruby.el

(autoload 'ruby-mode "ruby-mode"
  "Mode for editing ruby source files" t)

(setq auto-mode-alist
      (append '(("\\.rb$" . ruby-mode)) auto-mode-alist))

(setq interpreter-mode-alist
      (append '(("ruby" . ruby-mode)) interpreter-mode-alist))

(autoload 'run-ruby "inf-ruby" "Run an inferior Ruby process")

(autoload 'inf-ruby-keys "inf-ruby"
  "Set local key defs for inf-ruby in ruby-mode")

(add-hook 'ruby-mode-hook
          '(lambda ()
            (add-to-list 'load-path
                         "/usr/share/emacs/site-lisp/ruby1.8-elisp/")
            (inf-ruby-keys)))

(defun my-c-mode-hook ()
  (c-set-style "ruby"))

(add-hook 'c-mode-hook 'my-c-mode-hook)

(c-add-style "ruby"
             '("bsd"
               (c-basic-offset . 4)
               (c-offsets-alist (case-label . 2)
                                (label . 2)
                                (statement-case-intro . 2)
                                (statement-case-open . 2))))
;;; init-ruby.el
(add-to-load-path "~/.emacs.d/elisp/ruby/")
(require 'ruby-mode)
(require 'ruby-electric)
(add-hook 'ruby-mode-hook
          '(lambda () (ruby-electric-mode t)))

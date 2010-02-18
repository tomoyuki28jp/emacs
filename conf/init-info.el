;;; init-info.el
;;; mode-info
;;; reference: http://d.hatena.ne.jp/higepon/20080828/1219932411

(add-to-list 'load-path "/usr/share/emacs/site-lisp/mode-info/")

(require 'mi-config)
(setq mode-info-index-directory "~/info/index")
(define-key global-map "\C-chf" 'mode-info-describe-function)
(define-key global-map "\C-chv" 'mode-info-describe-variable)
(define-key global-map "\M-." 'mode-info-find-tag)
(require 'mi-fontify)

(setq mode-info-class-alist
      '((elisp  emacs-lisp-mode lisp-interaction-mode)
        (libc   c-mode c++-mode)
        (make   makefile-mode)
        (perl   perl-mode cperl-mode eperl-mode)
        (ruby   ruby-mode)
        (gauche scheme-mode scheme-interaction-mode inferior-scheme-mode)))

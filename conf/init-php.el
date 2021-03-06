;;; init-php.el

(load-library "php-mode")
(require 'php-mode)
(add-to-list 'auto-mode-alist (cons "\\.ctp$" 'html-mode))
(add-hook 'php-mode-hook
          (lambda ()
            (c-set-style "stroustrup")
            (setq tab-width 4)
            (setq c-basic-offset 4)
            (setq c-hanging-comment-ender-p nil)
            (setq php-mode-force-pear t)
            (setq indent-tabs-mode nil)
            (setq php-manual-path "/usr/local/share/php/manual")
            (setq tags-file-name "/usr/local/share/php/etags/TAGS")
            (global-set-key "\M-TAB" 'php-complete-function)
            (define-key c-mode-map "/" 'self-insert-command)
            (define-key java-mode-map "/" 'self-insert-command)
            (setq comment-style 'extra-line)
            (setq comment-continue " * ")
            (setq comment-start "/**")
            (setq comment-end " */")
            (jaspace-mode-on)
            (setq jaspace-highlight-tabs t)
            (c-set-offset 'arglist-close 0)))

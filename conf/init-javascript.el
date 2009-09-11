;;; init-javascript.el

(add-to-list 'auto-mode-alist '("\\.js\\'" . javascript-mode))
(autoload 'javascript-mode "javascript" nil t)
(add-hook 'javascript-mode-hook
          (lambda () (setq indent-tabs-mode nil)))

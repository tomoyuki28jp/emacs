;;; init-objc.el

(add-to-list 'auto-mode-alist '("\\.mm$" . objc-mode))
(add-to-list 'auto-mode-alist '("\\.h$ " . objc-mode))

(ffap-bindings)
(setq ffap-newfile-prompt t)
(setq ffap-kpathsea-depth 5)
(add-to-list 'objc-mode-hook (lambda () (setq c-basic-offset 4)))

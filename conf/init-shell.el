;; -*- Coding: utf-8 -*-
;; init-shell.el

;;; --- shell-mode -------------------------------
;; パスワードを表示しない
(add-hook 'comint-output-filter-functions
          'comint-watch-for-password-prompt)

;; shell-modeで^Mを出さなくする
(add-hook 'comint-output-filter-functions
          'shell-strip-ctrl-m nil t)


;;; --- term-mode --------------------------------
(require 'term)

;; term-modeに利用させないキー
(add-hook 'term-mode-hook
          (lambda ()
            (mapcar #'(lambda (key)
                        (define-key
                          term-raw-map key
                          (lookup-key (current-global-map) key)))
                    '("\C-z"                      ;; elscreen
                      "\C-s"                      ;; search
                      "\M-x"                      ;; emacs itself
                      "\C-n" "\C-p" "\C-f" "\C-b" ;; move cursor 1
                      "\C-v" "\M-v" "\M-<" "\M-<" ;; move cursor 2
                      ))))
;; color
(autoload 'ansi-color-for-comint-mode-on "ansi-color"
          "Set `ansi-color-for-comint-mode' to t." t)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

(defun zsh ()
  (interactive)
  (ansi-term "/usr/bin/zsh"))

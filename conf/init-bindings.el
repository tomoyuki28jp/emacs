;;; -*- Coding: utf-8 -*-
;;; init-bindings.el

(when (eq window-system 'x)
  (setq x-super-keysym 'meta)
  (setq x-meta-keysym 'super))

; Shift+カーソルkeyでwindowの切り替え
(windmove-default-keybindings)
; BS で選択範囲を消す
(delete-selection-mode 1)
; C-dやC-hで選択範囲全体を消す
(cua-selection-mode t)

; alias
(global-set-key "\C-h"  'delete-backward-char)
(global-set-key "\C-xl" 'goto-line)
(global-set-key "\C-o"  'dabbrev-expand)
(global-set-key "\M-/"  'ispell-complete-word)
(global-set-key "\C-co" 'outline-mode)
(global-set-key "\C-cf" 'folding-mode)
(global-set-key "\C-cb" 'rename-buffer)
(global-set-key "\M-8"  'pop-tag-mark)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-xf" 'flyspell-mode)

; resize window
;; for gnome-terminal
(global-set-key (kbd "A-<up>")    'enlarge-window)
(global-set-key (kbd "A-<down>")  'shrink-window)
(global-set-key (kbd "A-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "A-<left>")  'shrink-window-horizontally)
;; for urxvt
(global-set-key (kbd "ESC <up>")    'enlarge-window)
(global-set-key (kbd "ESC <down>")  'shrink-window)
(global-set-key (kbd "ESC <right>") 'enlarge-window-horizontally)
(global-set-key (kbd "ESC <left>")  'shrink-window-horizontally)

; kill all buffers
(global-set-key "\C-ck"
  (lambda ()
    (interactive)
    (loop for bf in (buffer-list)
          for bn = (buffer-name bf)
          unless (or (string= bn "*scratch*")
                     (string-match (rx bol (or (+ space) "#")) bn))
          do (kill-buffer bf))))

; prevent type for C-xu (undo)
(global-unset-key "\C-x\C-u")

;; for xterm，mlterm, etc
(define-key function-key-map [27 79 49 59 50 65] [S-up])
(define-key function-key-map [27 79 49 59 50 66] [S-down])
(define-key function-key-map [27 79 49 59 50 67] [S-right])
(define-key function-key-map [27 79 49 59 50 68] [S-left])

;; for mrxvt, screen, etc
(define-key function-key-map [27 91 49 59 50 65] [S-up])
(define-key function-key-map [27 91 49 59 50 66] [S-down])
(define-key function-key-map [27 91 49 59 50 67] [S-right])
(define-key function-key-map [27 91 49 59 50 68] [S-left])

;; for urxvt, etc
(define-key function-key-map [27 91 97] [S-up])
(define-key function-key-map [27 91 98] [S-down])
(define-key function-key-map [27 91 99] [S-right])
(define-key function-key-map [27 91 100] [S-left])

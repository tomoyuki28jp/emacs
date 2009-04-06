;;; -*- Coding: utf-8 -*-
;;; init-bindings.el

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

; resize window
(global-set-key (kbd "A-<up>")    'enlarge-window)
(global-set-key (kbd "A-<down>")  'shrink-window)
(global-set-key (kbd "A-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "A-<left>")  'shrink-window-horizontally)

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

;;; -*- Coding: utf-8 -*-
;;; init-tramp.el

(require 'tramp)
(setq tramp-default-method "ssh")
(setq tramp-auto-save-directory "/tmp")

; バッファ名からtramp経由で読み込んだファイルかどうか判別
(defun tramp-file-p ()
  (string-match "^/ssh:"
                (if (null buffer-file-name)
                    ""
                  buffer-file-name)))
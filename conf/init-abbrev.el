;;; -*- Coding: utf-8 -*-
;;; init-abbrev.el

;; 保存ファイル
(setq abbrev-file-name "~/.abbrev_defs")
;; 略称展開のキーバインドを指定(M-SPC)
(define-key esc-map  " " 'expand-abbrev)
;; 起動時に保存した略称を読み込む
(quietly-read-abbrev-file)
;; 略称を保存する
(setq save-abbrevs t)

;;; -*- Coding: utf-8 -*-
;;; init-misc.el

;; ページ移動時にカーソル位置を保持
(setq scroll-preserve-screen-position t)
;; mouse yank時にカーソル位置を保持
(setq mouse-yank-at-point t)
;; yes,noをy,nにする
(fset 'yes-or-no-p 'y-or-n-p)
;; 起動時にメッセージを表示しない
(setq inhibit-startup-message t)
;; 一時マークモードの自動有効化
(setq-default transient-mark-mode t)
; ファイル末の改行がなければ追加
(setq require-final-newline t)
;; 大文字小文字を区別
(setq dabbrev-case-fold-search nil)
;; default to unified diffs
(setq diff-switches "-u")
;; ignore local variables
(add-to-list 'ignored-local-variables 'syntax)
;; クリップボードからコピー
(setq x-select-enable-clipboard t)
;; iswitchb
(setq iswitchb-mode t)
;; .gz なファイルを読めるように
(auto-compression-mode t)
;; tab width
(setq tab-width 4)
;; emacsclient サーバを起動
(server-start)
;; 補完は ignore-case で。
(setq completion-ignore-case t)
;; 現在行をハイライト
(global-hl-line-mode)
;; 画像ファイルを表示
(auto-image-file-mode)
;; 最終行でのnext-lineをスムーズに
(setq scroll-step 1
      scroll-conservatively 4)
;; 音を鳴らさない
(setq visible-bell t
      ring-bell-function 'ignore)
;; backup file を作らない
(setq auto-save-list-file-name nil
      auto-save-list-file-prefix nil
      make-backup-files nil)
;; for flyspell-mode
(setq ispell-program-name "/usr/bin/ispell")
;; ダイアログボックスを使わない
(setq use-dialog-boxes nil)
;; カーソル点滅しない
(blink-cursor-mode 0)
;; メニューバーを消す
(menu-bar-mode -1)
;; ツールバーを消す
(tool-bar-mode -1)
;; スクロールバーを消す
(set-scroll-bar-mode nil)
;; 列数表示
(column-number-mode 1)
;; 括弧の対応をハイライト.
(show-paren-mode 1)
;; フレーム情報を隠す
(setq mode-line-frame-identification " ")
;; frame-titleフォーマット設定
(setq frame-title-format
      (concat  "%b - emacs@" (system-name)))

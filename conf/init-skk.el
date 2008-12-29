;;; -*- Coding: utf-8 -*-
;; init-skk.el

;;; ddskk
(setq skk-aux-large-jisyo "/usr/share/skk/SKK-JISYO.L")
(setq skk-server-portnum 1178)
(setq skk-server-host "localhost")
(global-set-key "\C-x\C-j" 'skk-mode)
(global-set-key "\C-xj" 'skk-auto-fill-mode)
(global-set-key "\C-xt" 'skk-tutorial)
(autoload 'skk-mode "skk" nil t)
(autoload 'skk-auto-fill-mode "skk" nil t)
(autoload 'skk-isearch-mode-setup "skk-isearch" nil t)
(autoload 'skk-isearch-mode-cleanup "skk-isearch" nil t)

;; Enterキー押下で確定
(setq skk-egg-like-newline t)
;; 送り仮名が厳密に正しい候補を優先して表示
(setq skk-henkan-strict-okuri-precedence t)
(setq skk-auto-okuri-process t)
;; 辞書登録のとき、余計な送り仮名を送らない
(setq skk-check-okurigana-on-touroku 'auto)
;; lookコマンドを使った検索をする(これ便利)
(setq skk-use-look t)
;; isearch時にSKKをオフ for migemo
(setq skk-isearch-start-mode 'latin)
;; 複数のEmacsで個人辞書を共有する
(setq skk-share-private-jisyo t)
;; 西暦で表示
(setq skk-date-ad t)
;; 半角数字
(setq skk-number-style nil)
;; SKKにC-jを潰させない
(setq skk-kakutei-key (kbd "C-;"))

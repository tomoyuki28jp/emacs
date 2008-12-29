;;; -*- Coding: utf-8 -*-
;;; init-dabbrev-expand.el

;; 日本語・英語混じり文での区切判定
(defadvice dabbrev-expand
  (around modify-regexp-for-japanese activate compile)
  "Modify `dabbrev-abbrev-char-regexp' dynamically for Japanese words."
  (if (bobp)
      ad-do-it
    (let ((dabbrev-abbrev-char-regexp
           (let ((c (char-category-set (char-before))))
             (cond 
              ((aref c ?a) "[-_A-Za-z0-9]") ; ASCII
              ((aref c ?j) ; Japanese
               (cond
                ((aref c ?K) "\\cK") ; katakana
                ((aref c ?A) "\\cA") ; 2byte alphanumeric
                ((aref c ?H) "\\cH") ; hiragana
                ((aref c ?C) "\\cC") ; kanji
                (t "\\cj")))
              ((aref c ?k) "\\ck") ; hankaku-kana
              ((aref c ?r) "\\cr") ; Japanese roman ?
              (t dabbrev-abbrev-char-regexp)))))
      ad-do-it)))

;; dabbrev-expand-multiple
(require 'dabbrev-expand-multiple)
(global-set-key "\M-o" 'dabbrev-expand-multiple)

;; ;; config tooltip face.  reference : M-x list-colors-display
(setq dabbrev-expand-multiple-tooltip-params
      '((foreground-color . "grey75")
        (background-color . "navy blue")
        (border-color . "black")))
;; use tooltip.
(setq dabbrev-expand-multiple-use-tooltip t)
;; use inline display. (not use tooltip.)
; (setq dabbrev-expand-multiple-use-tooltip nil)

;; 補完候補を一度に5つにする
(setq dabbrev-expand-multiple-select-keys '("a" "s" "d" "f" "g"))
;; 複数候補表示に移るキーに / を足す
(add-to-list 'dabbrev-expand-multiple-multi-selection-keys "/")
;; 複数候補表示時に次の候補表示に使用するキーに n を足す
(add-to-list 'dabbrev-expand-multiple-next-keys "n")
;; 複数候補表示時に前の候補表示に使用するキーに p を足す
(add-to-list 'dabbrev-expand-multiple-previous-keys "p")
;; ツールチップを表示する秒数
(setq dabbrev-expand-multiple-tooltip-timeout 2000)
;; 10秒で消えるように設定する
(setq dabbrev-expand-multiple-tooltip-timeout 10)
;; 最初に展開した文字列に highlight をかける.
(setq dabbrev-expand-multiple-highlight-face 'highlight)
;; インライン表示のときに使用するフェイス.
(setq dabbrev-expand-multiple-inline-show-face 'underline)
;; インライン表示の見た目の変更 (アンダーラインをなしにする)
(setq dabbrev-expand-multiple-inline-show-face nil)

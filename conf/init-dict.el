;;; init-dic.el
; http://d.hatena.ne.jp/iriya_ufo/20080331/1206952871

(autoload 'sdic-describe-word "sdic"
  "describe word" t nil)
(autoload 'sdic-describe-word-at-point "sdic"
  "describe word at point" t nil)

(global-set-key "\C-cw" 'sdic-describe-word)
(global-set-key "\C-cW" 'sdic-describe-word-at-point)

(setq sdic-window-height 10)
(setq sdic-disable-select-window t)

(setq sdic-eiwa-dictionary-list
      '((sdicf-client "/usr/share/dict/gene.sdic")))
(setq sdic-waei-dictionary-list
      '((sdicf-client "/usr/share/dict/jedict.sdic")))

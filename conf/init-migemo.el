;;; init-migemo.el

(require 'migemo)

; turn-off migemo when emacs starts because migemo makes 
; anything.el horribly slow
(migemo-toggle-isearch-enable)
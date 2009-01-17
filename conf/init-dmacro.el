;;; init-dmacro.el

(defconst *dmacro-key* "\C-q" "Repeat key")
(global-set-key *dmacro-key* 'dmacro-exec)
(autoload 'dmacro-exec "dmacro" nil t)

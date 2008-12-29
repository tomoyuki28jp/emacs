;;; init-auto-complete.el
;; reference: http://www.emacswiki.org/emacs/AutoComplete

(defmacro set-ac-sources (hook src)
  `(add-hook ,hook
             (lambda ()
               (make-local-variable 'ac-sources)
               (setq ac-sources ,src))))

(when (require 'auto-complete nil t)
  (global-auto-complete-mode t)
  (set-face-background 'ac-selection-face "steelblue")
  (set-face-background 'ac-menu-face "skyblue")
  (define-key ac-complete-mode-map "\t" 'ac-expand)
  (define-key ac-complete-mode-map "\r" 'ac-complete)
  (define-key ac-complete-mode-map "\M-n" 'ac-next)
  (define-key ac-complete-mode-map "\M-p" 'ac-previous)
  (setq ac-auto-start t) ;; (setq ac-auto-start 3)
  (setq ac-sources '(ac-source-abbrev ac-source-words-in-buffer))

  (setf ac-modes (append ac-modes
                         '(eshell-mode term-mode lisp-mode)))
  (set-ac-sources 'emacs-lisp-mode-hook
                  '(ac-source-abbrev
                    ac-source-words-in-buffer
                    ac-source-symbols))
  (set-ac-sources 'eshell-mode
                  '(ac-source-abbrev
                    ac-source-words-in-buffer
                    ac-source-files-in-current-dir))
  (set-ac-sources 'term-mode
                  '(ac-source-abbrev
                    ac-source-words-in-buffer
                    ac-source-files-in-current-dir))
  (set-ac-sources 'lisp-mode-hook
                  '(ac-source-abbrev
                    ac-source-words-in-buffer)))

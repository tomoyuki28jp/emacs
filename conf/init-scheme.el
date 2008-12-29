;;; init-scheme.el

;; Gauche
(setq scheme-program-name "gosh -i")
(autoload 'scheme-mode "cmuscheme" "Major mode for Scheme" t)
(autoload 'run-scheme "cmuscheme" "Run an inferior Scheme process" t)
(defun scheme-other-window ()
  "Run scheme on other window"
  (interactive)
  (switch-to-buffer-other-window
   (get-buffer-create "*scheme*"))
  (run-scheme scheme-program-name))

;; http://www29.atwiki.jp/sicpstudygroup/pages/45.html
(autoload 'scheme-get-current-symbol-info "scheme-complete" nil t)
(autoload 'scheme-smart-complete "scheme-complete" nil t)

(eval-after-load 'scheme
  '(progn
    ;; scheme-smart-complete: M-TAB
    (define-key scheme-mode-map "\e\t" 'scheme-smart-complete)
    ;; scheme-complete-or-indent: TAB
    (define-key scheme-mode-map "\t" 'scheme-complete-or-indent)))

(add-hook 'scheme-mode-hook
  (lambda ()
    (setq default-scheme-implementation 'gauche)
    (setq *current-scheme-implementation* 'gauche)
    ;; eldoc-mode
    (set (make-local-variable 'eldoc-documentation-function)
         'scheme-get-current-symbol-info)
    (eldoc-mode t)
    (local-set-key "\C-cS" 'scheme-other-window)))

;; Kahua
(require 'kahua)
(setq auto-mode-alist
      (append '(("\\.kahua$" . kahua-mode)) auto-mode-alist))
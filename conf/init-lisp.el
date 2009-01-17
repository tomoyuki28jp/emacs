;;; init-lisp.el

(setq enable-local-variables :all)
(setq inferior-lisp-program "/usr/bin/sbcl")
(require 'slime)
(setq slime-net-coding-system 'utf-8-unix)

(eval-after-load "slime"
  '(progn
    (require 'slime-fancy)
    (slime-setup '(slime-fancy slime-asdf slime-banner))
    (setq slime-complete-symbol*-fancy t)
    (setq slime-complete-symbol-function
          'slime-fuzzy-complete-symbol)))

(defun slime-other-window ()
  "Run slime on other window"
  (interactive)
  (let ((tmp-buffer "*tmp*"))
    (switch-to-buffer-other-window
     (get-buffer-create tmp-buffer))
    (slime)
    (kill-buffer tmp-buffer)))

(add-hook 'lisp-mode-hook
          (lambda ()
            (slime-mode t)
            (setq indent-tabs-mode nil)
            (show-paren-mode t)
            (local-set-key "\C-ce"  'slime-eval-buffer)
            (local-set-key "\C-cS"  'slime-other-window)
            (local-set-key "\C-cS"  'slime-other-window)
            (local-set-key "\C-chf" 'hyperspec-lookup)
            (slime-define-key "\M-." 'find-tag)
            (slime-define-key "\M-8" 'pop-tag-mark)))

(add-hook 'emacs-lisp-mode-hook
          (lambda () (setq indent-tabs-mode nil)))

(defun slime-restart ()
  (interactive)
  (mapcar #'(lambda (b)
              (let ((buff (get-buffer b)))
                (when buff (kill-buffer buff))))
          '("*slime-repl sbcl*"
            "*compiler notes*"))
  (slime-restart-inferior-lisp))

(global-set-key "\C-xrs" 'slime-restart)

(setq common-lisp-hyperspec-root
      (expand-file-name "~/Documents/HyperSpec/"))

;;; init-lisp.el

(when (eq system-type 'darwin)
  (add-to-load-path "~/.emacs.d/elisp/slime/"))

(setq enable-local-variables :all)
(setq inferior-lisp-program (if (eq system-type 'darwin) "/opt/local/bin/sbcl" "/usr/bin/sbcl"))
;(setq inferior-lisp-program "/home/tomo/src/lisp/ccl/lx86cl /home/tomo/src/lisp/ccl/ccl-deb")
;(setq inferior-lisp-program "/usr/local/acl81_express/alisp")
(require 'slime)
(setq slime-net-coding-system 'utf-8-unix)

(eval-after-load "slime"
  '(progn
    (add-to-list 'load-path "~/.emacs.d/elisp/slime/contrib/")
    (require 'slime-fancy)
    (slime-setup
     '(slime-fancy slime-asdf slime-banner slime-tramp))
    (setq slime-complete-symbol*-fancy  t
          lisp-simple-loop-indentation  1
          lisp-loop-keyword-indentation 6
          lisp-loop-forms-indentation   6
          slime-complete-symbol-function
          'slime-fuzzy-complete-symbol)
    (setf slime-filename-translations
          (list (slime-create-filename-translator
                 :machine-instance "tomoyuki"
                 :remote-host "tomoyuki"
                 :username "tomo")
                (list ".*" 'identity 'identity)))))

(defun slime-other-window ()
  "Run slime on other window"
  (interactive)
  (when (one-window-p)
    (split-window-horizontally))
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
            (local-set-key "\C-cS"  'slime-other-window)))

(add-hook 'emacs-lisp-mode-hook
          (lambda ()
            (setq indent-tabs-mode nil)
            (eldoc-mode t)))

(defun slime-restart ()
  (interactive)
  (mapcar #'(lambda (b)
              (let ((buff (get-buffer b)))
                (when buff (kill-buffer buff))))
          '("*slime-repl sbcl*"
            "*slime-repl openmcl*"
            "*slime-repl allegro*"
            "*compiler notes*"))
  (slime-restart-inferior-lisp))

(global-set-key "\C-xrs" 'slime-restart)
(global-set-key "\C-chf" 'hyperspec-lookup)

(setq common-lisp-hyperspec-root
      (expand-file-name "/usr/local/share/doc/HyperSpec/"))

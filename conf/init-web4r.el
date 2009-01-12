;;; init-web4r.el
;;; web4r: common lisp web application framework

(defvar *web4r-src-dir* (expand-file-name "~/src/lisp/web4r/"))

(defvar *sbcl-cache-dir*
  "/var/cache/common-lisp-controller/1000/sbcl/local")

(defvar *web4r-cache-dir* (concat *sbcl-cache-dir* *web4r-src-dir*))

(defun exec-concat-cmd (&rest args)
  (shell-command-to-string (apply #'concat args)))

(defun rm-dir  (dir)
  (exec-concat-cmd "rm -rf " dir))

(defun rm-fasl (dir)
  (exec-concat-cmd "find " dir " -type f -name '*.fasl' -exec rm {} \\;"))

(defun remove-fasl ()
  (interactive)
  (rm-dir *web4r-cache-dir*)
  (rm-fasl *web4r-src-dir*))

(add-hook 'lisp-mode-hook
          (lambda () (local-set-key "\C-crf" 'remove-fasl)))

(setq auto-mode-alist
      (append '(("\\.shtml$" . lisp-mode)) auto-mode-alist))

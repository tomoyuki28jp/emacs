;;; init-web4r.el
;;; web4r: common lisp web application framework

(defun delete-fasl ()
  (interactive)
  (shell-command-to-string
   (concat
    "for i in "
    "`find " (expand-file-name "~/src/lisp/web4r/") " -name \"*.fasl\"`;"
    " do rm $i; done;")))

(setq auto-mode-alist
      (append '(("\\.shtml$" . lisp-mode)) auto-mode-alist))

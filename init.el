(defun add-to-load-path (&rest paths)
  (mapcar
   #'(lambda (p)
       (add-to-list 'load-path (expand-file-name p)))
   paths))

(add-to-load-path
 "~/.emacs.d/elisp"
 "~/.emacs.d/conf")

(require 'bitlbee)
(require 'moccur-edit)

(mapcar #'load
        (append
         '("init-misc"
           "init-coding"
           "init-color"
           "init-scratch"
           "init-dabbrev-expand"
           "init-migemo"
           "init-stumpwm"
           "init-anything"
           "init-yasnippet"
           "init-tramp"
           "init-shell"
           "init-jaspace"
           "init-dmacro"
           "init-elscreen"
           "init-rcirc"
           "init-erc"
           "init-moz"
           "init-wl"
           "init-w3m"
           "init-dict"
           "init-git"
           "init-html"
           "init-javascript"
           "init-php"
           "init-scheme"
           "init-lisp"
           "init-web4r"
           "init-markdown"
           "init-org"
           "init-bindings")
         (if (eq window-system 'x)
             '("init-font")
           '("init-xsel"))))

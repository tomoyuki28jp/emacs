(defun add-to-load-path (&rest paths)
  (mapcar
   #'(lambda (p)
       (add-to-list 'load-path (expand-file-name p)))
   paths))

(add-to-load-path
 "~/.emacs.d/elisp"
 "~/.emacs.d/conf")

(mapcar #'load
        (append
         '("init-misc"
           "init-coding"
           "init-color"
           "init-scratch"
           "init-dabbrev-expand"
           "init-migemo"
           "init-anything"
           "init-yasnippet"
           "init-tramp"
           "init-shell"
           "init-jaspace"
           "init-dmacro"
           "init-elscreen"
           "init-bitlbee"
           "init-rcirc"
           "init-moz"
           "init-wl"
           "init-w3m"
           "init-dict"
           "init-git"
           "init-html"
           "init-javascript"
           "init-php"
           "init-lisp"
           "init-web4r"
           "init-stumpwm"
           "init-markdown"
           "init-bindings")
         (if (eq window-system 'x)
             '("init-font")
           '("init-xsel"))))

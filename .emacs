(defun add-to-load-path (&rest paths)
  (mapcar
   #'(lambda (p)
       (add-to-list 'load-path (expand-file-name p)))
   paths))

(add-to-load-path
 "~/.emacs.d/elisp"
 "~/.emacs.d/conf")

(when (eq system-type 'darwin)
  (add-to-load-path "/usr/local/share/emacs/site-lisp/"))

(mapcar #'load
        (append
         '("init-notify"
           "init-misc"
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
           "init-rcirc"
           "init-erc"
           "init-moz"
           "init-w3m"
           "init-dict"
           "init-git"
           "init-javascript"
           "init-php"
           "init-java"
           "init-scheme"
           "init-lisp"
           "init-markdown"
           "init-org"
           "init-ruby"
           "init-rvm"
           "init-stumpwm"
           "init-web4r"
           "init-mew"
           "init-moccur"
           "init-install"
           "init-bindings")
         (if window-system
             '(
;               "init-html"
               "init-css"
               "init-rails")
           (unless (eq system-type 'darwin)
             '("init-xsel")))
         (if (eq system-type 'darwin)
             '("init-frame"
               "init-objc")
           '("init-font"))))

(setq ffap-newfile-prompt nil)

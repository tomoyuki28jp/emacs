;; init.el

(defun add-to-load-path (&rest paths)
  (mapcar #'(lambda (path)
              (add-to-list 'load-path
                           (expand-file-name path)))
          paths))

(add-to-load-path
 "~/.emacs.d/elisp"
 "~/.emacs.d/conf")

(mapcar 'load
        '("init-misc"
          "init-encoding"
          "init-font"
          "init-color"
          "init-frame"
          "init-scratch"
          "init-skk"
          "init-dabbrev-expand"
          "init-abbrev"
          "init-migemo"
          "init-anything"
          "init-yasnippet"
          "init-tramp"
          "init-shell"
          "init-jaspace"
          "init-dmacro"
          "init-elscreen"
          "init-folding"
          "init-woman"
          "init-bitlbee"
          "init-rcirc"
          "init-install"
          "init-moz"
          "init-wl"
          "init-w3m"
          "init-navi2ch"
          "init-dict"
          "init-git"
          "init-html"
          "init-javascript"
          "init-php"
          "init-ruby"
          "init-lisp"
          "init-web4r"
          "init-scheme"
          "init-sql"
          "init-stumpwm"
          "init-bindings"))

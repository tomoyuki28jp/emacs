;;; init-elscreen.el

(add-to-load-path "~/.emacs.d/elisp/elscreen/")

(when (and (eq system-type 'darwin) (null window-system))
  (add-to-load-path "/Applications/Emacs.app/Contents/Resources/site-lisp/apel/")
  (add-to-load-path "/Applications/Emacs.app/Contents/Resources/site-lisp/emu/"))

(load "elscreen")
(load "elscreen-dnd")
(load "elscreen-dired")
(load "elscreen-server")
;(load "elscreen-w3m")

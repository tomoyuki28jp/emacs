;;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

(if (eq window-system 'x)
    (progn
      (add-to-load-path "~/.emacs.d/elisp/color-theme/")
      (require 'color-theme)
      (color-theme-initialize)
      (color-theme-billw))  
  (progn
    (set-face-foreground 'font-lock-comment-face "darkolivegreen3")
    (set-face-background 'highlight "black")
    (set-face-foreground 'highlight "white")
    ))

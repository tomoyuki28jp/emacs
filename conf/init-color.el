;;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

(add-to-load-path "~/.emacs.d/elisp/color-theme/")
(require 'color-theme)
(color-theme-initialize)
(color-theme-dark-laptop)
(set-face-foreground 'font-lock-comment-face "yellow")
(set-face-background 'highlight "brightblack")
(set-face-foreground 'highlight "white")

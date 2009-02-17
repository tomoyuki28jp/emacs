;;; init-markdown.el

(add-to-load-path "~/.emacs.d/elisp/markdown-mode/")

(autoload 'markdown-mode "markdown-mode.el"
   "Major mode for editing Markdown files" t)

(loop for i in '("\\.mdwn" "\\.md" "\\.mdt")
      do (add-to-list 'auto-mode-alist (cons i 'markdown-mode)))

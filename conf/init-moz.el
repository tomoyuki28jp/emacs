;;; init-moz.el

(autoload 'moz-minor-mode "moz"
  "Mozilla Minor and Inferior Mozilla Modes" t)
(moz-minor-mode 1)
(defun moz-send-reload ()
  (interactive)
  (comint-send-string
   (inferior-moz-process)
   (concat moz-repl-name ".pushenv('printPrompt', 'inputMode'); "
           moz-repl-name ".setenv('inputMode', 'line'); "
           moz-repl-name ".setenv('printPrompt', false); undefined; "))
  (comint-send-string
   (inferior-moz-process)
   (concat "content.location.reload();\n"
           moz-repl-name
           ".popenv('inputMode', 'printPrompt'); undefined;\n")))
(global-set-key "\C-cr" 'moz-send-reload)

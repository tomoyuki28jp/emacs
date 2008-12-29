;;; init-mew.el

;(add-to-list 'load-path "/usr/local/share/emacs/site-lisp/mew/")
(autoload 'mew "mew" nil t)
(autoload 'mew-send "mew" nil t)

(autoload 'mew-user-agent-compose "mew" nil t)
(when (boundp 'mail-user-agent)
  (setq mail-user-agent 'mew-user-agent))
(when (fboundp 'define-mail-user-agent)
  (define-mail-user-agent
    'mew-user-agent
    'mew-user-agent-compose
    'mew-draft-send-message
    'mew-draft-kill
    'mew-send-hook))
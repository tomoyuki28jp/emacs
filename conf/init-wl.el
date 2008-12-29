;;; init-wl.el

(autoload 'wl "wl" "Wanderlust" t)
(autoload 'wl-draft "wl-draft" "Write draft with Wanderlust." t)
(autoload 'wl-other-frame "wl" "Wanderlust on new frame." t)

(when (boundp 'mail-user-agent)
  (setq mail-user-agent 'wl-user-agent))
(when (fboundp 'define-mail-user-agent)
  (define-mail-user-agent
    'wl-user-agent
    'wl-user-agent-compose
    'wl-draft-send
    'wl-draft-kill
    'mail-send-hook))
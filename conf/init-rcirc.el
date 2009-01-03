;;; init-rcirc.el

(require 'rcirc)

;; Don't print /away messages.
(defun rcirc-handler-301 (process cmd sender args)
  "/away message handler.")

;; Keep input line at bottom.
(add-hook 'rcirc-mode-hook
          (lambda ()
            (flyspell-mode 1)
            (set (make-local-variable 'scroll-conservatively) 8192)))

;; Turn the debugging mode on
;(setq rcirc-debug-flag t)

;; Adjust the colors of one of the faces.
(set-face-foreground 'rcirc-my-nick "red" nil)

;; example of ~/.emacs.d/.auth/auth-rcirc.el
;(setq rcirc-default-nick "nick-name")
;(setq rcirc-default-user-name "user-name")
;
;(setq rcirc-authinfo
;      `(("freenode"  nickserv "user" "pass")
;        ("localhost" bitlbee  "user" "pass")))
(let ((auth-file "~/.emacs.d/.auth/auth-rcirc.el"))
  (when (file-readable-p auth-file)
    (load auth-file)))

(global-set-key (kbd "C-c j") 'rcirc-cmd-join)

(defun freenode ()
  (interactive)
  (let ((rcirc-server-alist  '(("irc.freenode.net"))))
    (rcirc nil)))

(defun bitlbee ()
  (interactive)
  (unless (bitlbee-running-p) (bitlbee-start))
  (sleep-for 0.5)
  (let ((rcirc-server-alist '(("localhost" :channels ("&bitlbee")))))
    (rcirc nil)))

;; Notifications
(defun th-rcirc-notification (process sender response target text)
  (let ((my-nick (rcirc-nick process)))
    (when (and (string= response "PRIVMSG")
               (not (string= sender my-nick))
               (not (and (string= sender  "root")
                         (string= target  "&bitlbee")))
               (or
                ;; BitlBee IM messages
                (string-match "localhost" (format "%s" process))
                ;; Messages that mention my name
                (string-match my-nick text)))
      (th-notifications-add (concat "rcirc: " target)))))

(add-hook 'rcirc-print-hooks 'th-rcirc-notification)

(defun th-notifications-add (str)
  (interactive "sNotification: ")
  (start-process "notifications-add" nil
                 "stumpish" "notifications-add" str))

(setq rcirc-log-flag t)
(setq rcirc-log-directory "~/log/rcirc")

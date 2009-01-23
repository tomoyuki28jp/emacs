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

; Auto auth with ~/.rcirc-authinfo don't work for me somehow.
; http://www.emacswiki.org/emacs/rcircAutoAuthentication.
; I use ~/.emacs.d/.auth/auth-rcirc.el instead.
; [Example]
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

(setq rcirc-startup-channels-alist nil)

(defun freenode ()
  (interactive)
  (rcirc nil))

(defun bitlbee ()
  (interactive)
  (unless (bitlbee-running-p)
    (bitlbee-start))
  (sleep-for 0.5)
  (rcirc-connect
   "localhost" "6667" "tomoyuki28jp" "Tomo Matsumoto" "&bitlbee"))

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

 ;  Minimal logging
(add-hook 'rcirc-print-hooks 'rcirc-write-log)
(defvar my-rcirc-log-dir "~/.emacs.d/log/rcirc/")
(defun rcirc-write-log (process sender response target text)
  (with-temp-buffer
    ;; Sometimes TARGET is a buffer :-(
    (when (bufferp target)
      (setq target (with-current-buffer buffer rcirc-target)))
    ;; Sometimes buffer is not anything at all!
    (unless (or (null target) (string= target ""))
      ;; Print the line into the temp buffer.
      (insert (format-time-string "%Y-%m-%d %H:%M "))
      (insert (format "%-16s " (rcirc-user-nick sender)))
      (unless (string= response "PRIVMSG")
        (insert "/" (downcase response) " "))
      (insert text "\n")
      ;; Append the line to the appropriate logfile.
      (let* ((coding-system-for-write 'no-conversion)
             (log-dir (concat my-rcirc-log-dir
                              (downcase target)
                              (format-time-string "/%Y/%m/")))
             (log-file (format-time-string "%d")))
        (unless (file-exists-p log-dir)
          (make-directory log-dir t))
        (write-region (point-min) (point-max)
                      (concat log-dir log-file)
                      t 'quietly)))))

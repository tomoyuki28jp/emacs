;;; init-erc.el

(defun tiarra ()
  (interactive)
  (erc :server tiarra-server
       :port 6667
       :nick "tomoyuki28jp"
       :password tiarra-pass))

(erc-spelling-mode 1)

(setq erc-current-nick-highlight-type 'nick)
;(setq erc-keywords '("tomoyuki28jp"))
(setq erc-track-exclude-types '("JOIN" "PART" "QUIT" "NICK" "MODE"))
(setq erc-track-use-faces t)
;(setq erc-track-faces-priority-list '(erc-current-nick-face erc-keyword-face))
(setq erc-track-priority-faces-only 'all)

(add-hook 'erc-text-matched-hook
          (lambda (match-type nickuserhost message)
            (let* ((channel (car (split-string (buffer-name) "@")))
                   (exclude-keywords
                    '("^*** Welcome to the Internet Relay Network"
                      "^*** ChanServ (ChanServ@services.) has changed mode for"
                      "^*** Users on #"))
                   (matched (loop for keyword in exclude-keywords
                                  when (string-match keyword message) return t)))
              (unless matched
                (notify "erc" channel)))))

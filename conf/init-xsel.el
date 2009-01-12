;;; init-xsel.el
; http://d.hatena.ne.jp/pakepion/20081209/1228828521

(setq interprogram-paste-function
      (lambda ()
         (shell-command-to-string "xsel -b -o")))

(setq interprogram-cut-function
      (lambda (text &optional rest)
         (let* ((process-connection-type nil)
                (proc (start-process
                      "xsel" "*Messages*" "xsel" "-b" "-i")))
           (process-send-string proc text)
           (process-send-eof proc))))

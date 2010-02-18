;; init-notify.el

(defun notify (title msg)
  (if (eq system-type 'darwin)
      (shell-command (format "growlnotify -t '%s' -m '%s'" title msg))
    (start-process
     "notifications-add" nil
     "stumpish" "notifications-add" title ": " msg)))

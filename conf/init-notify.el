;; init-notify.el

(defun notify (title msg)
  (if (eq system-type 'darwin)
      (shell-command (format "growlnotify -t '%s' -m '%s'" title msg))
    (start-process
     "notifications-add" nil
     "stumpish" "notifications-add" title ": " msg)))

(defun notify2 (title msg)
  (if (eq system-type 'darwin)
      (notify nil msg)
    (start-process "notify-send" nil "notify-send" title msg)))

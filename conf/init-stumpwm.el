;;; init-stumpwm.el

(require 'stumpwm-mode)

(defun stumpish (msg)
  (start-process
   "notifications-add" nil
   "stumpish" "notifications-add" msg))

;;; init-frame.el

(if (eq system-type 'darwin)
  (set-frame-parameter nil 'alpha '(100 80))
  (set-frame-parameter nil 'height 50)
  (set-frame-parameter nil 'width 180)
  (set-frame-parameter nil 'top 0)
  (set-frame-parameter nil 'left 0)

  (defun toggle-fullscreen ()
    (interactive)
    (set-frame-parameter
     nil 'fullscreen
     (unless (frame-parameter nil 'fullscreen) 'fullboth)))

  (global-set-key "\C-cf" 'toggle-fullscreen))

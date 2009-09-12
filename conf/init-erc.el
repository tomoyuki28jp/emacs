;;; init-erc.el

(defun tiarra ()
  (interactive)
  (erc :server tiarra-server
       :port 6667
       :nick "tomoyuki28jp"
       :password tiarra-pass))

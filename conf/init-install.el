;;; init-install.el

(require 'install-elisp)
(setq install-elisp-repository-directory "~/.emacs.d/elisp/")

(require 'auto-install)
(setq auto-install-directory "~/.emacs.d/elisp/")
(auto-install-update-emacswiki-package-name t)
(auto-install-compatibility-setup)

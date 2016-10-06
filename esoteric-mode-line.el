;; Nicer statusbar
(require 'esoteric-package-install)

(esoteric-package-install 'mode-icons)
(esoteric-package-install 'smart-mode-line)

(setq sml/show-eol t)

(defun esoteric-setup-mode-line ()
  (column-number-mode t) ; show column number in mode line
  (mode-icons-mode t))

;; hide minor modes that don't have additional menu buttons
(setq rm-whitelist (append rm-whitelist '(" FlyC" " yas")))

(add-hook 'emacs-startup-hook 'esoteric-setup-mode-line) ; demon-mode fails if this was at afer-init

(provide 'esoteric-mode-line)



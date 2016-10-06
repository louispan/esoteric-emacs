(require 'recentf)

(setq recentf-max-menu-items 100
      recentf-max-saved-items 100)

(defun esoteric-setup-recentf ()
  (recentf-mode t))

(add-hook 'emacs-startup-hook 'esoteric-setup-recentf)

(provide 'esoteric-recentf)

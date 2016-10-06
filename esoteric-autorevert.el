(defun esoteric-setup-autorevert ()
  (global-auto-revert-mode t)) ; detect if file has changed
(add-hook 'emacs-startup-hook 'esoteric-setup-autorevert)

(provide 'esoteric-autorevert)
(require 'esoteric-eshell)

(defun esoteric-setup-eshell-clear-buffer-key()
    (local-set-key (kbd "C-l") 'eshell-clear-buffer))

(add-hook 'eshell-mode-hook 'esoteric-setup-eshell-clear-buffer-key)

(provide 'esoteric-eshell-key)
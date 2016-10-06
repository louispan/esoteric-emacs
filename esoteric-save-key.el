; saving
(require 'esoteric-save)

(global-set-key (kbd "C-s") #'esoteric-save-buffer-or-scratch)
(global-set-key (kbd "C-S-s") #'save-some-buffers)

(provide 'esoteric-save-key)

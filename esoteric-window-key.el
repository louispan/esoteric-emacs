;; Switching windows
(require 'esoteric-window)
(require 'esoteric-window-switch)

;; NB. Don't get confused with C-w which is kill-this-buffer due to esoteric-quit-key.el
(global-set-key (kbd "M-w") 'esoteric-window-switch-forward)
(global-set-key (kbd "M-W") 'esoteric-window-switch-backward)

(define-key speedbar-mode-map (kbd "b") (lambda () (interactive)
        (speedbar-change-initial-expansion-list "buffers")))

(provide 'esoteric-window-key)

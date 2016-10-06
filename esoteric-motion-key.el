;;; Motion
(require 'esoteric-motion)

(setq scroll-conservatively 100) ; try not to recenter cursor

(global-set-key (kbd "M-<left>") 'esoteric-backward-subword)
(global-set-key (kbd "C-M-<left>") 'backward-sexp)
(global-set-key (kbd "C-<left>") 'crux-move-beginning-of-line)
(global-set-key (kbd "<home>") 'crux-move-beginning-of-line)

(global-set-key (kbd "M-<right>") 'esoteric-forward-subword)
(global-set-key (kbd "C-M-<right>") 'forward-sexp)
(global-set-key (kbd "C-<right>") 'move-end-of-line)
(global-set-key (kbd "<end>") 'move-end-of-line)

(global-set-key (kbd "M-<up>") 'backward-paragraph)
(global-set-key (kbd "C-<up>") 'scroll-down-command) ; ie scroll buffer down
(global-set-key (kbd "C-M-<up>") 'beginning-of-buffer)

(global-set-key (kbd "M-<down>") 'forward-paragraph)
(global-set-key (kbd "C-<down>") 'scroll-up-command) ; ie scroll buffer up
(global-set-key (kbd "C-M-<down>") 'end-of-buffer)

(provide 'esoteric-motion-key)

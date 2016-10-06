;;; Erasing
(require 'esoteric-silent-cua)

(global-set-key (kbd "M-<backspace>") 'esoteric-silently-backward-delete-subword)
(global-set-key (kbd "C-M-<backspace>") 'esoteric-silently-backward-delete-sexp)
(global-set-key (kbd "C-<backspace>") 'esoteric-silently-delete-line-backwards)
;; C-S-<backspace> is kill-whole-line by emacs default
(global-set-key (kbd "C-S-<backspace>") 'esoteric-silently-delete-whole-line)

(global-set-key (kbd "M-<delete>") 'esoteric-silently-forward-delete-subword)
(global-set-key (kbd "C-M-<delete>") 'esoteric-silently-forward-delete-sexp)
(global-set-key (kbd "C-<delete>") 'esoteric-silently-delete-line)

(provide 'esoteric-erase-key)

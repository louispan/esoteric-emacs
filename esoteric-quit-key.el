(require 'esoteric-quit)

;; Quitting
;; (global-set-key (kbd "C-q") 'esoteric-save-buffers-kill-terminal-ask) ;; NB. C-q was for quoted insert
(global-set-key (kbd "C-q") 'save-buffers-kill-terminal) ;; NB. C-q was for quoted insert
(global-set-key (kbd "M-v") #'quoted-insert) ; C-q was change to Quit, so quoted-insert is now M-v (like bash quoted insert C-v)
(global-set-key (kbd "C-w") 'kill-this-buffer)
(global-set-key (kbd "C-M-w") 'delete-window) ; was append-next-kill
(global-set-key (kbd "M-c") 'minibuffer-keyboard-quit)
;; Keep M-c means quit consistent in isearch
;; Change case toggle to M-S-c
(define-key isearch-mode-map (kbd "M-c") 'isearch-abort)
(define-key isearch-mode-map (kbd "M-C") 'isearch-toggle-case-fold)

(require 'esoteric-cua)
(defun esoteric-quit-setup-cua-keymaps ()
  (define-key cua--cua-keys-keymap [(meta v)] nil)) ; reclaiming this shortcut for quoted-insert
(add-hook 'cua-mode-hook 'esoteric-quit-setup-cua-keymaps)

(provide 'esoteric-quit-key)

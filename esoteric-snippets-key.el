(require 'esoteric-snippets)

; NB "M-SPC" is linux menu
(global-set-key (kbd "C-S-SPC") 'helm-yas-complete) ; memonic S for snippets

(require 'esoteric-cua)
(defun esoteric-snippets-setup-cua-keymaps ()
  (define-key cua-global-keymap [(shift control ?\s)] nil)) ; reclaiming this shortcut for snippets
(add-hook 'cua-mode-hook 'esoteric-snippets-setup-cua-keymaps)

(provide 'esoteric-snippets-key)

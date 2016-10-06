;;; Undo & Suspend
(require 'esoteric-package-install)

(esoteric-package-install 'undo-tree)

(setq undo-tree-auto-save-history t)
(setq undo-tree-history-directory-alist (quote (("." . "~/.cache/emacs"))))
(setq undo-tree-visualizer-timestamps t)

;; This needs to be set early and not as a hook on emacs-startup-hook
;; otherwise loading undo history doesn't work
(global-undo-tree-mode t)

(provide 'esoteric-undo)
;; miscellaneous tweaks for usability
(setq inhibit-startup-screen t)

;; http://ergoemacs.org/emacs/emacs_alias.html
(defalias 'yes-or-no-p 'y-or-n-p) ; y or n is enough

(global-unset-key (kbd "C-<next>")) ; remove confusing default of screen sideways
(global-unset-key (kbd "<f2>")) ; emacs two column mode is horrible
(global-unset-key (kbd "C-_")) ; remove undo, in case it's accidentally pressed while M-_ (jump forward in esoteric-mark)

;; Stop creating #file#
(setq auto-save-default nil)

;; Stop creating ~files~
(setq make-backup-files nil)

;; Stop asking if symlinks are ok
(setq vc-follow-symlinks t)

;; case insensitive sort-lines
(require 'sort)
(setq sort-fold-case t)

(provide 'esoteric-tweaks)

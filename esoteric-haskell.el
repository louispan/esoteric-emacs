;;; Haskell

;; Install Intero
(require 'esoteric-package-install)
(esoteric-package-install 'intero)

(add-hook 'haskell-mode-hook 'intero-mode)

(defun esoteric-haskell-cabal-mode-hook ()
  ;; - is punctuation and not part of a word
  (modify-syntax-entry ?- ". 123"))
(add-hook 'haskell-cabal-mode-hook #'esoteric-haskell-cabal-mode-hook)

(defun esoteric-haskell-mode-comment-or-uncomment-fun (start end)
  "haskell pragmas are also considered comments, but I don't ever want to uncomment pragmas
  so detect pragmas and comment them first"
  ;; if any line is a pragma, then comment
  ;; else use comment-or-uncomment
  (if (save-restriction
        (narrow-to-region start end)
        (goto-char (point-min))
        (search-forward-regexp "^[:space:]*{-#\\|^[:space:]*{-@" (point-max) t))
      (comment-region start end)
    (comment-or-uncomment-region start end)))

(defun esoteric-haskell-kill-buffer-hook ()
  "Haskell intero flycheck actually secretly saves the files in order to check syntax.
  This breaks undo history if files aren't saved by the user when quitting,
  so save the history on kill buffer."
  (when (and (derived-mode-p 'haskell-mode) (buffer-file-name) intero-mode flycheck-mode)
    (undo-tree-save-history nil t)))

(defun esoteric-haskell-save-all-buffers-undo-history (&rest ignore)
  (mapcar
    (lambda (buf) (with-current-buffer buf (esoteric-haskell-kill-buffer-hook)))
    (buffer-list)))

(advice-add #'save-buffers-kill-emacs :before #'esoteric-haskell-save-all-buffers-undo-history)
(advice-add #'save-some-buffers :before #'esoteric-haskell-save-all-buffers-undo-history)

(defun esoteric-haskell-mode-setup ()
  ;; {-# pragmas are not a separate paragraphs so it's easy to jump
  ;; past language pragmas at the top of the file
  (setq-local paragraph-start (concat " *{-[^#@]\\| *-- |\\|" page-delimiter))

  (require 'esoteric-commenter)
  (setq-local esoteric-comment-or-uncomment-region-fun #'esoteric-haskell-mode-comment-or-uncomment-fun)

  ;; with -ddump-splices flycheck complains about "Undefined error level: splice"
  (require 'flycheck)
  (make-symbol "splice")
  ;; same as 'info
  (flycheck-define-error-level 'splice
    :severity -10
    :compilation-level 0
    :overlay-category 'flycheck-info-overlay
    :fringe-bitmap 'flycheck-fringe-bitmap-double-arrow
    :fringe-face 'flycheck-fringe-info
    :error-list-face 'flycheck-error-list-info)

  (add-hook 'kill-buffer-hook #'esoteric-haskell-kill-buffer-hook t))

(add-hook 'haskell-mode-hook 'esoteric-haskell-mode-setup)


;; haskell-indentation-indent-backwards calls haskell-indentation-indent-rigidly with -1 spacing
;; This is an advice to indent by standard-indent

(require 'haskell-mode)
;; create a custom function that calls single multiplying arg by standard-indent
(defun esoteric-haskell-indentation-indent-rigidly (orig-fun &rest args)
  "Rigidly indents by arg * standard-indent"
  (setf (nth 2 args) (* standard-indent (nth 2 args)))
  (apply orig-fun args)
  (setq deactivate-mark nil)) ; nil keep mark selection

(advice-add #'haskell-indentation-indent-rigidly :around #'esoteric-haskell-indentation-indent-rigidly)

;; haskell-indentation-mode's haskell-indentation-indent-region is a noop
;; change it to indent rigidly
(advice-add #'haskell-indentation-indent-region :after #'esoteric-rigidly-indent-region)

(require 'esoteric-mark)

;; When jumping, mark the previous spot
(advice-add #'intero-goto-definition :before #'esoteric-mark)
(advice-add #'haskell-navigate-imports :before #'esoteric-mark)
(advice-add #'haskell-navigate-imports-go :before #'esoteric-mark)

(defun esoteric-intero-make-options-list (orig-fun &rest args)
  "Add --ghc-options -fdefer-type-errors to intero"
  (append (apply orig-fun args)
          (list "--ghci-options" "-fdefer-type-errors")))

(advice-add #'intero-make-options-list :around #'esoteric-intero-make-options-list)

;; hlint was removed from intero - renable it
;; https://www.reddit.com/r/haskell/comments/4wva2m/intero_for_emacs_changes_junejuly/
(flycheck-add-next-checker 'intero '(warning . haskell-hlint))

(require 'esoteric-haskell-snippets)

;; chrisdone's auto indent formatter
;; M-q reformats the current declaration. When inside a comment, it fills the current paragraph instead, like the standard M-q.
;; C-M-\ reformats the current region.
(esoteric-package-install 'hindent)
(add-hook 'haskell-mode-hook #'hindent-mode)

(provide 'esoteric-haskell)

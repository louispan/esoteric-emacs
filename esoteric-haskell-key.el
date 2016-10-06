(require 'esoteric-haskell)
;M-x haskell-navigate-imports
;M-x haskell-mode-format-imports Or C-c C-..
;M-x haskell-sort-imports
;M-x haskell-align-imports
;M-x haskell-mode-stylish-buffer. ; need to install stylish haskell
;haskell-decl-scan-mode   M-x imenu support
;C-M-a Move to beginning of current or preceding declaration (beginning-of-defun).
;C-M-e Move to end of current or following declaration (end-of-defun).
;C-M-h Select whole current or following declaration (mark-defun).
;M-x speedbar; requires speedbar
;haskell-compile; need binding C-c C-c.
;http://haskell.github.io/haskell-mode/manual/latest/Aligning-code.html#Aligning-code
; M-x align-regexp  M-x align-regexp
(require 'intero)

(define-key intero-mode-map (kbd "<f4>") 'intero-info)
(define-key intero-mode-map (kbd "M-i") 'intero-info) ; memonic (i)nfo, originally tab-to-tab-stop
(define-key intero-mode-map (kbd "<f5>") 'intero-type-at)
(define-key intero-mode-map (kbd "M-t") 'intero-type-at) ; memonic (t)ype
(define-key intero-mode-map (kbd "<f6>") 'intero-goto-defoinition) ; also M-. by emacs default
(define-key intero-mode-map (kbd "<f7>") 'intero-repl-load)

(provide 'esoteric-haskell-key)

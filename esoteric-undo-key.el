;;; Undo & Suspend
(require 'esoteric-undo)

(global-set-key (kbd "C-z") 'undo-tree-redo)
(global-set-key (kbd "C-y") 'undo-tree-redo) ; Microsoft bindings. C-y was paste
(global-set-key (kbd "C-S-z") 'undo-tree-redo) ; Linux & Mac style
(global-set-key (kbd "M-u") 'undo-tree-visualize) ; Linux & Mac style

;; Remove unnecessary keys so only my shortcuts show up in minibuffer candidates
;; I like using C-/ for commenting like other IDEs
(global-set-key (kbd "C-/") nil) ; Linux & Mac style
(define-key undo-tree-map (kbd "C-/") nil) ; undo is now C-z
(define-key undo-tree-map "\C-_" nil) ; undo is now C-z
(define-key undo-tree-map (kbd "C-?") nil) ; 'undo-tree-redo
(define-key undo-tree-map (kbd "M-_") nil) ; ''undo-tree-redo
(define-key undo-tree-map (kbd "\C-x u") nil); 'undo-tree-visualie

(provide 'esoteric-undo-key)

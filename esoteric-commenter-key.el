(require 'esoteric-commenter)

;; Comment/uncomment to ctrl+/ (same as atom/sublime)
(global-set-key (kbd "C-/") 'esoteric-comment-or-uncomment-region-or-line)

(provide 'esoteric-commenter-key)

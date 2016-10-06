(require 'esoteric-suspend)
;; C-Z is undo, so create a Alt-Z for suspend (or minimise GUI)
(global-set-key (kbd "M-z") 'esoteric-suspend)

(provide 'esoteric-suspend-key)
(require 'esoteric-mouse)

;; Prevents <wheel-left> is undefined messages
(define-key global-map (kbd "<wheel-left>") 'ignore)
(define-key global-map (kbd "<wheel-right>") 'ignore)

(provide 'esoteric-mouse-key)

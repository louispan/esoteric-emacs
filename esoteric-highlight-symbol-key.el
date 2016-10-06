;; Mark symobl
(require 'esoteric-highlight-symbol)

;; NB. f2 used to be start keyboard macro
(global-set-key [(control f2)] 'highlight-symbol)
(global-set-key [f2] 'highlight-symbol-next)
(global-set-key [(shift f2)] 'highlight-symbol-prev)
(global-set-key [(control meta f2)] 'highlight-symbol-query-replace)

(provide 'esoteric-highlight-symbol-key)

(require 'esoteric-haskell)

(require 'esoteric-yaml)

(add-hook 'yaml-mode-hook
  '(lambda ()
    (define-key yaml-mode-map "\C-m" 'newline-and-indent)))

(provide 'esoteric-yaml-key)

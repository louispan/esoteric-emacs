(require 'esoteric-package-install)
(require 'esoteric-helm)

(esoteric-package-install 'yasnippet)

(esoteric-package-install 'helm-c-yasnippet)

(setq helm-yas-space-match-any-greedy t)

;; yas mode breaks tab completion in term
(add-hook 'prog-mode-hook 'yas-minor-mode) ; Enable snippets only for source, not shell


(provide 'esoteric-snippets)

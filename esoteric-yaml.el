;;; yaml

(require 'esoteric-package-install)
(esoteric-package-install 'yaml-mode)

(add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))
(add-to-list 'auto-mode-alist '("\\.yaml\\'" . yaml-mode))

(provide 'esoteric-yaml)

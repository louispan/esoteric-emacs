(require 'esoteric-package-install)

(require 'esoteric-indent)

(esoteric-package-install 'vimrc-mode)
(add-to-list 'auto-mode-alist '(".vim\\(rc\\)?$" . vimrc-mode))

(add-hook 'vimrc-mode-hook #'esoteric-set-local-indent-rigidly)

(provide 'esoteric-vimrc)

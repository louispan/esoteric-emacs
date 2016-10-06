(require 'esoteric-package-install)

;; Completion
(setq completion-ignored-extensions
     (append
         completion-ignored-extensions
         '(".o" ".aux" ".hi" ".dyn_o" ".dyn_hi" ".dump_hi")))

(esoteric-package-install 'company)
(add-hook 'emacs-startup-hook 'global-company-mode)

(provide 'esoteric-completion)

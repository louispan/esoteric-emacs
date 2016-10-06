(require 'esoteric-package-install)
(require 'esoteric-search-dirs)

;; Project browsing, detects .git
;; Manually add .projectile to root directory if autodetect doesn't work.
(esoteric-package-install 'projectile)

(require 'esoteric-search-dirs)
(setq projectile-globally-ignored-directories
  (append projectile-globally-ignored-directories (esoteric-ignored-search-dirs)))

(defun esoteric-setup-projectile ()
  (projectile-global-mode t))
(add-hook 'emacs-startup-hook 'esoteric-setup-projectile)


(provide 'esoteric-projectile)

;; If you don't have MELPA in your package archives:
(require 'package)
  (add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
  (add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)

(defun esoteric-package-install (package)
  "'package-install' and 'require' the package, calling 'package-refresh-contents' if needed."
  (interactive "sPackage name: ")
  (ignore-errors
    (package-install package))
  ;; package install fails if we have never got package list from melpa
  (unless (package-installed-p package)
    (package-refresh-contents)
    (package-install package))
  (require package))

;; quelpa for installing from source
(unless (require 'quelpa nil t)
  (with-temp-buffer
    (url-insert-file-contents "https://raw.github.com/quelpa/quelpa/master/bootstrap.el")
    (eval-buffer)))

(provide 'esoteric-package-install)

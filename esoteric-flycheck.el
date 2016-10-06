(require 'esoteric-package-install)
(esoteric-package-install 'flycheck)

;; Flycheck opens on the bottom quarter of screen
;; http://www.flycheck.org/en/latest/user/error-list.html#tune-error-list-display
;; http://www.lunaryorn.com/2015/04/29/the-power-of-display-buffer-alist.html
(add-to-list 'display-buffer-alist
             `(,(rx bos "*Flycheck errors*" eos)
              (display-buffer-reuse-window
               display-buffer-in-side-window)
              (side            . bottom)
              (reusable-frames . visible)
              (window-height   . 0.25)))

(defun esoteric-flycheck-check-syntax-automatically-on-idle (globally)
  "Set buffer local flycheck-check-syntax-automatically to '(idle-change new-line save mode-enabled).
  If prefix is specified, set flycheck-check-syntax-automatically globally"
  (interactive "P")
  (let ((xs '(idle-change new-line save mode-enabled)))
    (if globally
      (setq flycheck-check-syntax-automatically xs)
      (setq-local flycheck-check-syntax-automatically xs))))

(defun esoteric-flycheck-check-syntax-automatically-on-new-line (globally)
  "Set buffer local flycheck-check-syntax-automatically to '(new-line save mode-enabled).
  If prefix is specified, set flycheck-check-syntax-automatically globally"
  (interactive "P")
  (let ((xs '(new-line save mode-enabled)))
    (if globally
      (setq flycheck-check-syntax-automatically xs)
      (setq-local flycheck-check-syntax-automatically xs))))

(defun esoteric-flycheck-check-syntax-automatically-on-save (globally)
  "Set buffer local flycheck-check-syntax-automatically to '(save mode-enabled).
  If prefix is specified, set flycheck-check-syntax-automatically globally"
  (interactive "P")
  (let ((xs '(save mode-enabled)))
    (if globally
      (setq flycheck-check-syntax-automatically xs)
      (setq-local flycheck-check-syntax-automatically xs))))

(provide 'esoteric-flycheck)

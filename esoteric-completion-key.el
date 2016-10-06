(require 'esoteric-completion)
(require 'esoteric-helm)

(global-set-key (kbd "C-SPC") 'company-complete)

; memontic helm uses Meta key
(eval-after-load 'company
  '(progn
    (define-key company-active-map (kbd "M-c") 'company-abort)
    (define-key company-mode-map (kbd "C-M-SPC") 'helm-company)
    (define-key company-active-map (kbd "C-M-SPC") 'helm-company)))

(provide 'esoteric-completion-key)
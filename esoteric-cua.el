(require 'cua-base)

(defun esoteric-activate-transient-mark ()
  ;; turn on highlighting
  (setq mark-active t)
  (setq deactivate-mark nil)
  ;; make the region transient
  ;; see simple.el handle-shift-selection
  (setq transient-mark-mode
        (cons 'only
              (unless (eq transient-mark-mode 'lambda)
                transient-mark-mode))))

(defun esoteric-mark-whole-buffer ()
  "Marks whole buffer and highlight the region"
  (interactive)
  ;; don't use mark-whole-buffer because I prefer to go to end of the buffer
  (push-mark (point))
  (push-mark (point-min) nil t)
  (goto-char (point-max))
  (esoteric-activate-transient-mark))

(defun esoteric-setup-cua ()
  (cua-mode t))
(add-hook 'emacs-startup-hook 'esoteric-setup-cua)

(provide 'esoteric-cua)

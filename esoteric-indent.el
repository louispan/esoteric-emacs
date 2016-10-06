;;; Identation

;; NB. Standard emacs practice is not to rebind <TAB>
;; but redefine indent-line-function for the indent function.
;; But I want normal major mode specific indent behaviour when indenting one line
;; and rigid behaviour when indenting region.
;; So alias indent-region to my custom rigid one.
(defun esoteric-rigidly-indent-region (start end)
   "Indent region rigidly."
   (indent-rigidly start end standard-indent)
   (setq deactivate-mark nil)) ;; keep mark selection active

(defun esoteric-rigidly-indent-line ()
  (let ((start (save-excursion (beginning-of-line) (point)))
        (end (save-excursion (end-of-line) (point))))
    (esoteric-rigidly-indent-region start end)))

; emacs default doesn't have unindent
(defun esoteric-rigidly-unindent-region-or-line (unindent-line-fun)
  "Uninent region or current line rigidly."
  (interactive)
  (cond
    ((use-region-p)
      (indent-rigidly (region-beginning) (region-end) (* -1 standard-indent))
      (setq deactivate-mark nil)) ;; keep mark selection active
    (t
      (funcall unindent-line-fun))))

; emacs default doesn't have unindent
(defun esoteric-rigidly-unindent ()
  (interactive)
  (esoteric-rigidly-unindent-region-or-line '(lambda () (indent-rigidly (line-beginning-position) (point) (* -1 standard-indent)))))

;; Turn tabs off for everything but Makefiles
(setq-default indent-tabs-mode nil)
(defun esoteric-setup-makefile-tab-indent ()
  (setq indent-tabs-mode t))
(add-hook 'makefile-mode-hook 'esoteric-setup-makefile-tab-indent)

(defun esoteric-set-local-indent-region-rigidly ()
  (interactive)
  (setq-local indent-region-function #'esoteric-rigidly-indent-region))

(defun esoteric-set-local-indent-line-rigidly ()
  (interactive)
  (setq-local indent-line-function #'esoteric-rigidly-indent-line))

(require 'esoteric-cua)

(defun esoteric-indent-region-keep-highlight (&rest ignore)
  (esoteric-activate-transient-mark))
(advice-add #'indent-region :after #'esoteric-indent-region-keep-highlight)

(defun esoteric-set-local-indent-rigidly ()
  (interactive)
  (esoteric-set-local-indent-region-rigidly)
  (esoteric-set-local-indent-line-rigidly)
  (electric-indent-mode 0))

(setq standard-indent 2)
(setq-default tab-width 2)

(provide 'esoteric-indent)

(require 'python)
(defun esoteric-rigidly-unindent-python ()
  (interactive)
  (esoteric-rigidly-unindent-region-or-line 'python-indent-dedent-line))

(define-key python-mode-map (kbd "<backtab>") 'esoteric-rigidly-unindent-python)

(provide 'esoteric-python-key)

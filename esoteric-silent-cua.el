(require 'cua-base)
(require 'esoteric-ignoring)
(require 'esoteric-erase)

(defun esoteric-silently-cua-paste (arg)
  (interactive "P")
  (esoteric-ignoring #'message #'cua-paste arg))

(defun esoteric-silently-copy-region-or-whole-line (arg)
  (interactive "P")
  (esoteric-ignoring #'message #'esoteric-copy-region-or-whole-line arg))

(defun esoteric-silently-cut-region-or-whole-line (arg)
  (interactive "P")
  (esoteric-ignoring #'message #'esoteric-cut-region-or-whole-line arg))

(defun esoteric-silently-backward-delete-word (arg)
  (interactive "p")
  (esoteric-ignoring #'message #'esoteric-backward-delete-word arg))

(defun esoteric-silently-forward-delete-word (arg)
  (interactive "p")
  (esoteric-ignoring #'message #'esoteric-forward-delete-word arg))

(defun esoteric-silently-backward-delete-subword (arg)
  (interactive "p")
  (esoteric-ignoring #'message #'esoteric-backward-delete-subword arg))

(defun esoteric-silently-forward-delete-subword (arg)
  (interactive "p")
  (esoteric-ignoring #'message #'esoteric-forward-delete-subword arg))

(defun esoteric-silently-backward-delete-sexp (arg)
  (interactive "p")
  (esoteric-ignoring #'message #'esoteric-backward-delete-sexp arg))

(defun esoteric-silently-forward-delete-sexp (arg)
  (interactive "p")
  (esoteric-ignoring #'message #'esoteric-forward-delete-sexp arg))

(defun esoteric-silently-delete-line-backwards ()
  (interactive)
  (esoteric-ignoring #'message #'esoteric-delete-line-backwards))

(defun esoteric-silently-delete-line ()
  (interactive)
  (esoteric-ignoring #'message #'esoteric-delete-line))

(defun esoteric-silently-delete-whole-line (arg)
  (interactive "p")
  (esoteric-ignoring #'message #'esoteric-delete-whole-line arg))

(defun esoteric-silently-undo (&optional arg)
  (interactive "*P")
  (esoteric-ignoring #'message #'undo arg))

(provide 'esoteric-silent-cua)

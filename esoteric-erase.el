;; Delete words or lines

(require 'esoteric-motion)
(require 'cua-base)

(defun esoteric-forward-delete-subword (arg)
  "Delete word forwards.
Save a copy in register 0 if `cua-delete-copy-to-register-0' is non-nil."
  (interactive "p")
  (cua-set-mark nil)
  (esoteric-forward-subword arg)
  (cua-delete-region))

(defun esoteric-backward-delete-subword (arg)
  "Delete word backwards
Save a copy in register 0 if `cua-delete-copy-to-register-0' is non-nil."
  (interactive "p")
  (cua-set-mark nil)
  (esoteric-backward-subword arg)
  (cua-delete-region))

(defun esoteric-forward-delete-word (arg)
  "Delete word forwards.
Save a copy in register 0 if `cua-delete-copy-to-register-0' is non-nil."
  (interactive "p")
  (cua-set-mark nil)
  (esoteric-forward-word arg)
  (cua-delete-region))

(defun esoteric-backward-delete-word (arg)
  "Delete word backwards
Save a copy in register 0 if `cua-delete-copy-to-register-0' is non-nil."
  (interactive "p")
  (cua-set-mark nil)
  (esoteric-backward-word arg)
  (cua-delete-region))

(defun esoteric-forward-delete-sexp (arg)
  "Delete sexp forwards.
Save a copy in register 0 if `cua-delete-copy-to-register-0' is non-nil."
  (interactive "p")
  (cua-set-mark nil)
  (forward-sexp arg)
  (cua-delete-region))

(defun esoteric-backward-delete-sexp (arg)
  "Delete sexp backwards
Save a copy in register 0 if `cua-delete-copy-to-register-0' is non-nil."
  (interactive "p")
  (cua-set-mark nil)
  (backward-sexp arg)
  (cua-delete-region))

(defun esoteric-forward-kill-word (arg)
  "Delete word forwards and put into kill-ring"
  (interactive "p")
  (kill-region (point) (progn (esoteric-forward-word arg) (point))))

(defun esoteric-backward-kill-word (arg)
  "Delete word backwards and put into kill-ring"
  (interactive "p")
  (kill-region (point) (progn (esoteric-backward-word arg) (point))))

(defun esoteric-forward-kill-subword (arg)
  "Delete word forwards and put into kill-ring"
  (interactive "p")
  (kill-region (point) (progn (esoteric-forward-subword arg) (point))))

(defun esoteric-backward-kill-subword (arg)
  "Delete word backwards and put into kill-ring"
  (interactive "p")
  (kill-region (point) (progn (esoteric-backward-subword arg) (point))))

(defun esoteric-forward-cut-word (reg &optional num)
  "Cut a word forwards and copy to the kill ring.
Unsets last-command so cut will not append.
With numeric prefix reg, copy to register 0-9 instead.
num for specifying how many words to cut."
  (interactive "P")
  ;; unset last-command so cut will not append.
  (setq last-command nil)
  (cua-set-mark nil)
  (esoteric-forward-word (if (null num) 1 num))
  (cua-cut-region reg))

(defun esoteric-backward-cut-word (reg &optional num)
  "Cut a word backwards and copy to the kill ring.
Unsets last-command so cut will not append.
With numeric prefix reg, copy to register 0-9 instead.
num for specifying how many words to cut."
  (interactive "P")
  ;; unset last-command so cut will not append.
  (setq last-command nil)
  (cua-set-mark nil)
  (esoteric-backward-word (if (null num) 1 num))
  (cua-cut-region reg))

(defun esoteric-forward-cut-subword (reg &optional num)
  "Cut a word forwards and copy to the kill ring.
Unsets last-command so cut will not append.
With numeric prefix reg, copy to register 0-9 instead.
num for specifying how many words to cut."
  (interactive "P")
  ;; unset last-command so cut will not append.
  (setq last-command nil)
  (cua-set-mark nil)
  (esoteric-forward-subword (if (null num) 1 num))
  (cua-cut-region reg))

(defun esoteric-backward-cut-subword (reg &optional num)
  "Cut a word backwards and copy to the kill ring.
Unsets last-command so cut will not append.
With numeric prefix reg, copy to register 0-9 instead.
num for specifying how many words to cut."
  (interactive "P")
  ;; unset last-command so cut will not append.
  (setq last-command nil)
  (cua-set-mark nil)
  (esoteric-backward-subword (if (null num) 1 num))
  (cua-cut-region reg))

(defun esoteric-delete-line-backwards ()
  "Delete line backwards and adjust the indentation.
Save a copy in register 0 if `cua-delete-copy-to-register-0' is non-nil."
  (interactive)
  (cua-set-mark nil)
  (move-beginning-of-line 1)
  (cua-delete-region)
  (indent-according-to-mode))

(defun esoteric-delete-line ()
  "Delete line forwards.
Save a copy in register 0 if `cua-delete-copy-to-register-0' is non-nil."
  (interactive)
  (cua-set-mark nil)
  (move-end-of-line 1)
  (cua-delete-region))

(defun esoteric-delete-whole-line (&optional arg)
  "Deletes whole lines, with a optional arg of how many lines to delete.
Save a copy in register 0 if `cua-delete-copy-to-register-0' is non-nil."
  (interactive "p")
  (cond
    ; eg 2 delete this + next line
    ((< 0 arg)
      (move-beginning-of-line 1)
      (cua-set-mark nil)
      (ignore-errors (move-end-of-line arg) (forward-char))
      (cua-delete-region))

    ; eg -2 delete prev + prev line, point at end of previous line
    ((> 0 arg)
      (move-beginning-of-line arg)
      (cua-set-mark nil)
      (ignore-errors (move-end-of-line 1) (forward-char))
      (cua-delete-region))
    ; 0 delete without new line
    (t
      (move-beginning-of-line 1)
      (cua-set-mark nil)
      (move-end-of-line 1)
      (cua-delete-region)))
  (back-to-indentation))

(defun esoteric-kill-whole-line (&optional arg)
  "Kills whole line (into kill ring), with a optional arg of how many lines to kill."
  (interactive "p")
  (cond
    ; eg 2 delete this + next line
    ((< 0 arg)
      (kill-region
        (progn (move-beginning-of-line 1) (point))
        (progn (ignore-errors (move-end-of-line arg) (forward-char)) (point))))
    ; eg -2 delete prev + prev line, point at end of previous line
    ((> 0 arg)
      (kill-region
        (progn (move-beginning-of-line arg) (point))
        (progn (ignore-errors (move-end-of-line 1) (forward-char)) (point))))
    ; 0 delete without new line
    (t
      (kill-region
        (progn (move-beginning-of-line 1) (point))
        (progn (move-end-of-line 1) (point)))))
  (back-to-indentation))

(defun esoteric-cut-whole-line (reg &optional num)
  "Cuts the whole line, with a optional arg of how many lines to erase.
Unsets last-command so cut will not append.
With numeric prefix reg, copy to register 0-9 instead.
num for specifying how many words to cut."
  (interactive "P")
  ;; unset last-command so cut will not append.
  (setq last-command nil)
  (let ((arg (if (null num) 1 num)))
    (cond
      ; eg 2 delete this + next line
      ((< 0 arg)
        (move-beginning-of-line 1)
        (cua-set-mark nil)
        (ignore-errors (move-end-of-line arg) (forward-char))
        (cua-cut-region reg))
      ; eg -2 delete prev + prev line, point at end of previous line
      ((> 0 arg)
        (move-beginning-of-line arg)
        (cua-set-mark nil)
        (ignore-errors (move-end-of-line 1) (forward-char))
        (cua-cut-region reg))
      ; 0 delete without new line
      (t
        (move-beginning-of-line 1)
        (cua-set-mark nil)
        (move-end-of-line 1)
        (cua-cut-region reg))))
  (back-to-indentation))

(defun esoteric-copy-whole-line (reg &optional num)
  "Copy whole line to the kill ring.
With numeric prefix arg, copy to register 0-9 instead."
  (interactive "P")
  (save-excursion
    (let ((arg (if (null num) 1 num)))
      (cond
        ; eg 2 delete this + next line
        ((< 0 arg)
          (move-beginning-of-line 1)
          (cua-set-mark nil)
          (ignore-errors (move-end-of-line arg) (forward-char))
          (cua-copy-region reg))
        ; eg -2 delete prev + prev line, point at end of previous line
        ((> 0 arg)
          (move-beginning-of-line arg)
          (cua-set-mark nil)
          (ignore-errors (move-end-of-line 1) (forward-char))
          (cua-copy-region reg))
        ; 0 delete without new line
        (t
          (move-beginning-of-line 1)
          (cua-set-mark nil)
          (move-end-of-line 1)
          (cua-copy-region reg))))
    (back-to-indentation)))

(defun esoteric-delete-region-or-whole-line ()
  (interactive)
  "Either Delete a region or if no region was selected, kills the whole line"
  (if (use-region-p)
    (cua-delete-region)
    (esoteric-delete-whole-line 1)))

(defun esoteric-kill-region-or-whole-line ()
  (interactive)
  "Either kill a region or if no region was selected, kills the whole line"
  (if (use-region-p)
    (kill-region (region-beginning) (region-end))
    (esoteric-kill-whole-line 1)))

(defun esoteric-cut-region-or-whole-line (arg)
  (interactive "P")
  "Either cut a region or if no region was selected, cuts the whole line.
Unsets last-command so cut will not append.
With numeric prefix arg, copy to register 0-9 instead."
  ;; unset last-command so cut will not append.
  (setq last-command nil)
  (if (use-region-p)
    (cua-cut-region arg)
    (esoteric-cut-whole-line arg 1)))

(defun esoteric-copy-region-or-whole-line (arg)
  (interactive "P")
  "Either copies a region or if no region was selected, copies the whole line.
With numeric prefix arg, copy to register 0-9 instead."
  (save-excursion
    (if (use-region-p)
      (progn (cua-copy-region arg) (setq deactivate-mark nil)) ; nil keep mark selection
      (esoteric-copy-whole-line arg 1))))

(provide 'esoteric-erase)

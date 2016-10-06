;;; Word motion
(require 'esoteric-package-install)
(esoteric-package-install 'crux)
(require 'subword)

(defun esoteric-respect-intangibility (orig)
  (let ((arg 1))
    ;; the following was copied from simple.el:move-beginning-of-line
    ;; Now find first visible char in the line.
    (while (and (< (point) orig) (invisible-p (point)))
      (goto-char (next-char-property-change (point) orig)))
    (let* ((first-vis (point))
          ;; See if fields would stop us from reaching FIRST-VIS.
          (first-vis-field-value (constrain-to-field first-vis orig (/= arg 1) t nil)))
      (goto-char (if (/= first-vis-field-value first-vis)
                   ;; If yes, obey them.
                   first-vis-field-value
                 ;; Otherwise, move to START with attention to fields.
                 ;; (It is possible that fields never matter in this case.)
                 (constrain-to-field (point) orig
                                     (/= arg 1) t nil))))))

(defun esoteric-motion-respects-intangibility-advice(orig-fun &rest args)
  "Makes sure move backwards motions respects intangibility for minibuffer prompts"
  (let ((orig (point)))
    (apply orig-fun args)
    (esoteric-respect-intangibility orig)))

(advice-add 'beginning-of-buffer :around #'esoteric-motion-respects-intangibility-advice)
(advice-add 'move-end-of-line :around #'esoteric-motion-respects-intangibility-advice)
(advice-add 'backward-char :around #'esoteric-motion-respects-intangibility-advice)
(advice-add 'left-char :around #'esoteric-motion-respects-intangibility-advice)
(advice-add 'right-char :around #'esoteric-motion-respects-intangibility-advice)

;; Inspired on http://stackoverflow.com/questions/13896402/kill-word-forward-word-should-stop-at-newline
;; Modified heavily to forward if point is at eol or bol.
(defun esoteric-forwards-internal (forward backward &optional n)
  "Forward word and stop at eol or bol or first indent"
  (let ((start (point)))
    (save-restriction
      ;; narrow region to eol
      (narrow-to-region start (line-end-position))
      ;; if at bol, then go to beginning of next word
      (if (bolp)
        (progn
          (funcall forward)
          (funcall backward)
          ;; if still at bol, then try end of next word
          (when (bolp)
            (funcall forward)))
        (funcall forward)))
    ;; if point hasn't moved, move to bol of next line
    (when (eq start (point))
      (ignore-errors (move-end-of-line 1) (forward-char)))))

(defun esoteric-backwards-internal (backward)
  "Backward word and stop at bol or eol"
  (let ((orig (point)))
    (save-restriction
      ;; narrow region to bol then move word
      (save-excursion
        (crux-move-beginning-of-line 1)
        (narrow-to-region orig (point)))
      (funcall backward))
    ;; if point hasn't moved, move to previous eol
    (when (eq orig (point))
      (move-end-of-line 0))))

(defun esoteric-backward-word-internal (forward backward arg)
  "Backward word and stop at bol or eol"
 (if (< 0 arg)
   (dotimes (i arg)
     (esoteric-backwards-internal backward))
   (dotimes (i (abs arg))
     (esoteric-forwards-internal forward backward))))

(defun esoteric-forward-word-internal (forward backward arg)
  "Forward word and stop at eol or bol or first indent"
  (if (< 0 arg)
    (dotimes (i arg)
      (esoteric-forwards-internal forward backward))
    (dotimes (i (abs arg))
      (esoteric-backwards-internal backward))))

(defun esoteric-forward-word (arg)
  (interactive "^p")
  (esoteric-forward-word-internal #'forward-word #'backward-word arg))

(defun esoteric-backward-word (arg)
  (interactive "^p")
  (esoteric-backward-word-internal #'forward-word #'backward-word arg))

(defun esoteric-forward-subword (arg)
  (interactive "^p")
  (esoteric-forward-word-internal #'subword-forward #'subword-backward arg))

(defun esoteric-backward-subword (arg)
  (interactive "^p")
  (esoteric-backward-word-internal #'subword-forward #'subword-backward arg))

(provide 'esoteric-motion)

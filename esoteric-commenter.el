;; http://stackoverflow.com/questions/20041904/eclipse-like-line-commenting-in-emacs/20064658#20064658
(defvar esoteric-comment-or-uncomment-region-fun #'comment-or-uncomment-region)

(defun esoteric-comment-or-uncomment-region-or-line()
  (interactive)
  (let ((start (line-beginning-position))
        (end (line-end-position)))
    (when (or (not transient-mark-mode) (region-active-p))
      (setq start (save-excursion
                    (goto-char (region-beginning))
                    (beginning-of-line)
                    (point))
            end (save-excursion
                  (goto-char (region-end))
                  (end-of-line)
                  (point))))
    (funcall esoteric-comment-or-uncomment-region-fun start end)))

(provide 'esoteric-commenter)

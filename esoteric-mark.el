;;http://stackoverflow.com/questions/3393834/how-to-move-forward-and-backward-in-emacs-mark-ring
;; customized to add messages to be the same as pop-to-mark-command
(defun estoeric-unpop-to-mark-command ()
  "Unpop off mark ring. Does nothing if mark ring is empty."
  (interactive)
      (when mark-ring
        (let ((start (point)))
          (setq mark-ring (cons (copy-marker (mark-marker)) mark-ring))
          (set-marker (mark-marker) (car (last mark-ring)) (current-buffer))
          (when (null (mark t)) (ding) (user-error "No mark set in this buffer"))
          (setq mark-ring (nbutlast mark-ring))
          (goto-char (marker-position (car (last mark-ring))))
          (when (eq start (point)) (message "Mark popped")))))

(require 'cua-base)
(defun esoteric-mark (&rest ignore)
  "Sets a mark in one easy command"
  (interactive)
  (push-mark-command nil nil)
  (deactivate-mark))

(setq mark-ring-max 50)

;; When jumping, mark the previous spot
(advice-add 'xref-find-definitions :before #'esoteric-mark) ; M-. ; goto definition

(provide 'esoteric-mark)

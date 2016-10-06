;; S-C-<return> and C-<return> for inserting newlines above and below point.

;; NB.C-<return is normally cua-set-rectangle-mark, so make sure
;; cua-rectangle-mark-key is customized to another key.

;; http://emacsredux.com/blog/2013/03/26/smarter-open-line/
(defun esoteric-open-line-below()
  "Insert an empty line after the current line.
Position the cursor at its beginning, according to the current mode."
  (interactive)
  (move-end-of-line nil)
  (newline-and-indent))

;; http://emacsredux.com/blog/2013/06/15/open-line-above/
(defun esoteric-open-line-above ()
  "Insert an empty line above the current line.
Position the cursor at it's beginning, according to the current mode."
  (interactive)
  (move-beginning-of-line nil)
  (newline-and-indent)
  (forward-line -1)
  (indent-according-to-mode))

(provide 'esoteric-open-line)
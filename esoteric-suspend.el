(defun esoteric-suspend ()
  "Suspends in console or minimise in gui mode."
  (interactive)
  (if (window-system)
    (iconify-or-deiconify-frame)
    (suspend-emacs)))

(provide 'esoteric-suspend)
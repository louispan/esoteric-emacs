
(defun esoteric-ignoring (ignore-fun orig-fun &rest args)
  "Calls orign-fun, supressing ignore-fun"
  (interactive)
  (advice-add ignore-fun :around #'ignore)
  (unwind-protect
    (apply orig-fun args)
    (advice-remove ignore-fun #'ignore)))

(defun esoteric-ignoring-many (ignore-funs orig-fun &rest args)
  "Calls orign-fun, supressing every function in ignore-funs"
  (interactive)
  (dolist (ignore-fun ignore-funs)
      (advice-add ignore-fun :around #'ignore))
  (unwind-protect
    (apply orig-fun args)
    (dolist (ignore-fun ignore-funs)
      (advice-remove ignore-fun #'ignore))))

(provide 'esoteric-ignoring)
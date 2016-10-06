;; find/replace mapping to C-H like modern IDEs

;M-x replace-string RET string RET newstring RET
;M-% string RET newstring RET
;C-M-% regexp RET newstring RET
(esoteric-package-install 'anzu)

;;M-x anzu-*
;; Unset original emacs for query-replace so my shortcuts show up in minibuffer candidates
(global-set-key (kbd "M-%") nil)
(global-set-key [remap query-replace] 'anzu-query-replace)
(global-set-key [remap query-replace-regexp] 'anzu-query-replace-regexp)
(global-set-key (kbd "C-h") 'anzu-isearch-query-replace) ; Can still use <f1> for help
(global-set-key (kbd "C-S-h") 'anzu-query-replace)
(global-set-key (kbd "C-M-h") 'anzu-isearch-query-replace-regexp)
(global-set-key (kbd "C-M-S-h") 'anzu-query-replace-regexp) ; NB. C-M-S-h used to be mark-defun

(provide 'esoteric-replace-key)

(require 'esoteric-indent)
;;; Identation

; override default indent-region with simple rigid version
;(defalias 'indent-region 'esoteric-rigidly-indent-region)
(global-set-key (kbd "<backtab>") 'esoteric-rigidly-unindent)

(provide 'esoteric-indent-key)

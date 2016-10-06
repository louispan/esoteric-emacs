;; S-C-<return> and C-<return> for inserting newlines above and below point.

;; NB.C-<return is normally cua-set-rectangle-mark, so make sure
;; cua-rectangle-mark-key is customized to another key.
(require 'esoteric-open-line)

(global-set-key [C-return] 'esoteric-open-line-below)

(global-set-key [(control shift return)] 'esoteric-open-line-above)

(provide 'esoteric-open-line-key)
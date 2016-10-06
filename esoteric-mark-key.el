(require 'esoteric-mark)

;; Mark (sets when selecting, not editing)
;; C-SPC C-SPC marks a spot
;; C-x C-x switch mark and point/cursor
;; C-x C-SPC (pop-global-mark)

; Using osx browser forward/backward mappings
; Can't use osx forward/back C-[ and C-] as C-[ is ESC
(global-set-key (kbd "M--") 'pop-to-mark-command)
(global-set-key (kbd "M-=") 'estoeric-unpop-to-mark-command)
(setq cua-rectangle-mark-key [M-S-return]) ; sticky select
(global-set-key (kbd "S-SPC") 'esoteric-mark)

(provide 'esoteric-mark-key)

;; Menu bar
;; Only allow menu bar in Cocoa (OSX) because it doesn't
;; it appears at top of screen
;; When ubuntu emacs also puts menu at top of screen
;; we can renable it for window-system x
(when (not (and (display-graphic-p) (featurep 'ns)))
    ;; NB. we get here in daemon mode but osx GUI seems to be fine with
    ;; actually leaving menu bar on
    (menu-bar-mode 0))

;; Tool bar takes too much space
(tool-bar-mode 0)

(global-set-key (kbd "S-<f10>") 'menu-bar-mode)

(provide 'esoteric-menu-bar-key)
(require 'esoteric-package-install)

;; Easy incrementing/decremeting of values
;; doremi-window-width+
;; doremi-window-height+
(esoteric-package-install 'doremi)

;; doremi-window+
(esoteric-package-install 'doremi-cmd)

(esoteric-package-install 'sr-speedbar)
(setq speedbar-initial-expansion-list-name "buffers")
(setq sr-speedbar-right-side nil) ; to be consistent with sublime
(setq sr-speedbar-width 15)

(require 'esoteric-window-switch)
(defun esoteric-sr-speedbar-open ()
  " Open speedbar then switch focus to previous window"
  (interactive)
  (sr-speedbar-open)
  (esoteric-window-switch-forward))

;; Make speedbar display buffer in previously focused window
(defun esoteric-display-buffer-in-previous-window (orig-fun &rest args)
  (let ((buf (car args))
        (win (car (esoteric-window-switch-forward-windows))))
    (if (or (eq (get-buffer-window "*SPEEDBAR*") win)
            (not (window-live-p win)))
        (apply orig-fun args)
      (set-window-buffer win buf)
      win)))

(defun esoteric-speedbar-buffer-click (orig-fun &rest args)
  (advice-add #'display-buffer :around #'esoteric-display-buffer-in-previous-window)
  (unwind-protect
    (apply orig-fun args)
    (advice-remove #'display-buffer #'esoteric-display-buffer-in-previous-window)))
(advice-add 'speedbar-buffer-click :around #'esoteric-speedbar-buffer-click)

;; set speedbar font
;; https://www.emacswiki.org/emacs/SrSpeedbar
(make-face 'esoteric-speedbar-face)
(set-face-attribute 'esoteric-speedbar-face nil :height 0.75)
(setq speedbar-mode-hook '(lambda () (buffer-face-set 'esoteric-speedbar-face)))

(provide 'esoteric-window)

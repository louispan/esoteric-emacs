;;; Mouse

;; scroll one line at a time (less "jumpy" than defaults)
;; https://www.emacswiki.org/emacs/SmoothScrolling
(setq mouse-wheel-scroll-amount '(3 ((shift)  . 1) ((control) . 0.5)))
(setq mouse-wheel-progressive-speed nil) ;; don't accelerate scrolling
(setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse
;(setq scroll-step 2) ;; keyboard scroll one line at a time

; for some reason the scroll wheel use different mouse number in xterm
(global-set-key [mouse-4] (lambda ()
                            (interactive)
                            (scroll-down 1)))
(global-set-key [mouse-5] (lambda ()
                            (interactive)
                            (scroll-up 1)))

(require 'xt-mouse)


;; Enable mouse support in xterm mode
;; enable xterm-mouse irregardless of whether we are in gui mode
;; or not, it doesn't affect the gui mode.
;; Emacs v 24.5.1 has xterm mouse drag tracking bugs
;; Emacs from source (at least v25.1.50.1) has fixed this.
;; apt-get install texinfo
;; apt-get build-dep emacs24
;; git clone https://github.com/emacs-mirror/emacs.git
;; cd emacs
;; autogen.sh
;; autogen.sh git
;; configure
(defun esoteric-setup-mouse ()
  (xterm-mouse-mode 1))
(add-hook 'emacs-startup-hook 'esoteric-setup-mouse)

(require 'esoteric-ignoring)
(defun esoteric-mouse-save-dont-kill (click)
  "Calls mouse-save-then-kill but prevents killing"
  (interactive "e")
  (esoteric-ignoring-many '(delete-region kill-region) #'mouse-save-then-kill click))

;; shift-mouseclick extends selection instead of change font popup
;; http://superuser.com/questions/521223/shift-click-to-extend-marked-region
(define-key global-map (kbd "<S-down-mouse-1>") 'esoteric-mouse-save-dont-kill)

(provide 'esoteric-mouse)

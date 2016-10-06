(require 'esoteric-package-install)

(require 'esoteric-menu-bar-key) ; disable menu for more screen real estate
(add-hook 'prog-mode-hook 'linum-mode) ; Enable linum only for source, not shell

;; Make it easier to see window has the cursor
(setq-default cursor-in-non-selected-windows nil)

(esoteric-package-install 'indent-guide)
(indent-guide-global-mode t)
;;; Different highlight for nested parenthesis
(esoteric-package-install 'rainbow-delimiters)
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)

(setq-default cursor-type (quote bar))

(defun esoteric-distinct-color (step base rgb)
    "Return an rgb that is at least different by STEP (between 0 and 1) from base"
    (let ((s (if (and (>= step 0) (<= step 1.0)) step 0.1))
                    (diff (abs (- rgb base))))
            (if (<= diff step)
        (if (>= base 0.5)
                (- base s)
                    (+ base s))
                rgb)))

(defun esoteric-distinct-fringe-with (step)
    "Make the fringe different from background.
Step is an integer between 0 and 100"
        (let ((fringe-background (color-name-to-rgb (face-background 'fringe)))
                    (default-background (color-name-to-rgb (face-background 'default))))
                (let ((new-color
                             (cl-mapcar
                                (apply-partially #'esoteric-distinct-color step)
                                default-background
                                fringe-background)))
                    (set-face-background 'fringe (apply 'color-rgb-to-hex new-color)))))

(defun esoteric-distinct-fringe (arg)
    "Makes the fringe different from the background.
Prefix is the amount to change and is a float 0 and 1.0.
Defaults to 10% if nil."
    (interactive "nChange fringe by how much [0 - 1.0]? ")
    (let ((step (if (consp arg) 0.1 arg)))
        (esoteric-distinct-fringe-with step)))

(defun esoteric-fix-region-distant-foreground ()
    "Some themes don't have distance foreground on the region-face.
which breaks the linum line numer is really dark and hard to see when there
is a selection."
    (interactive)
    (set-face-attribute 'region nil :distant-foreground "selectedMenuItemColor"))

;; Show trailing whitespaces and tabs
(setq show-trailing-whitespace t)

(face-spec-set 'whitespace-tab '((t (:background "firebrick1" :foreground "darkorange4"))))
(face-spec-set 'whitespace-empty '((t (:background "khaki1" ))))
(setq whitespace-style (quote (face trailing tabs empty tab-mark)))

(defun esoteric-setup-visual ()
  (global-hl-line-mode t) ; highlight cursor line (conflicts with highlight symbol)
  (show-paren-mode t) ; highlight matching parenthesis
  (global-whitespace-toggle-options t))
(add-hook 'emacs-startup-hook 'esoteric-setup-visual)

;; It is best to have the following empty linum face
;; It give the linenumber different coloring depending on the comment on the line
;; and selection highlighting.
(face-spec-set 'linum '((t nil)))

(provide 'esoteric-visual)

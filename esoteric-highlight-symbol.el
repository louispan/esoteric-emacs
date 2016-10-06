;; Mark symobl
(require 'esoteric-package-install)
(esoteric-package-install 'highlight-symbol)

;; Change highlight symbol to also highlight foreground differently
(defun esoteric-whiten-color (color)
   (apply #'color-rgb-to-hex (mapcar
      (lambda (v)
        (let ((d (- 1.0 v)))
            (if (<= d 0.1)
                1.0
              (+ v (/ d 2.0)))))
      (color-name-to-rgb color))))

(defun esoteric-darken-color (color)
   (apply #'color-rgb-to-hex (mapcar
      (lambda (v)
        (if (<= v 0.1)
            0
          (- v (/ v 2.0))))
      (color-name-to-rgb color))))

(defun esoteric-background-dark-p ()
  (let ((b (apply #'+ (color-name-to-rgb (face-background 'default)))))
    (< b 1.5)))

(defun esoteric-highlight-symbol-add-symbol (orig-fun &rest args)
  "Add distant-foreground to original highlight-symbol-add-symbol"
  (let ((symbol (nth 0 args))
        (color  (nth 1 args)))
    (unless (highlight-symbol-symbol-highlighted-p symbol)
      (when (equal symbol highlight-symbol)
        (highlight-symbol-mode-remove-temp))
      (let ((color (or color (highlight-symbol-next-color))))
        (unless (facep color)
          (if (esoteric-background-dark-p)
              (setq color `((background-color . ,(esoteric-darken-color color))
                            (foreground-color . ,(esoteric-whiten-color color))))
            (setq color `((background-color . ,(esoteric-whiten-color color))
                          (foreground-color . ,(esoteric-darken-color color))))))
        ;; highlight
        (highlight-symbol-add-symbol-with-face symbol color)))))

(advice-add #'highlight-symbol-add-symbol :around #'esoteric-highlight-symbol-add-symbol)

(defun esoteric-bounds-of-face-at-point ()
  (interactive)
  (let ((start (previous-single-property-change (point) 'face))
        (end (next-single-property-change (point) 'face)))
    (cons start end)))

(defun esoteric-get-text-of-face-at-point ()
  (interactive)
  (let ((bounds (esoteric-bounds-of-face-at-point)))
    (buffer-substring (car bounds) (cdr bounds))))

(defun esoteric-face-at-point-is-highlight-symbol ()
  "Assume if the face is a list, then it's from highlight-symbol-add-symbol"
  (consp (get-char-property (point) 'face)))

(defun esoteric-highlight-symbol-get-symbol (orig-fun &rest args)
  "If the region is active, return selected text, else return the symbol at point"
  (cond ((region-active-p)
         (regexp-quote (buffer-substring (region-beginning) (region-end))))
        ((esoteric-face-at-point-is-highlight-symbol)
         (let ((symbol (thing-at-point 'symbol))
               (text   (esoteric-get-text-of-face-at-point)))
           (when (and symbol
                      (not (member 0 (mapcar
                                      (lambda (e) (string-match e symbol))
                                      highlight-symbol-ignore-list))))
             (if (equal symbol text)
                 (concat (car highlight-symbol-border-pattern)
                         (regexp-quote symbol)
                         (cdr highlight-symbol-border-pattern))
               (regexp-quote text)))))
        (t (apply orig-fun args))))

(advice-add #'highlight-symbol-get-symbol :around #'esoteric-highlight-symbol-get-symbol)

(defun esoteric-bounds-of-thing-at-point (orig-fun &rest args)
  (cond ((region-active-p)
         (cons (region-beginning) (region-end)))
        ((esoteric-face-at-point-is-highlight-symbol)
         (esoteric-bounds-of-face-at-point))
        (t (apply orig-fun args))))

(defun esoteric-highlight-symbol-jump (orig-fun &rest args)
  "Modified to override bounds-of-thing-at-point"
  (advice-add #'bounds-of-thing-at-point :around #'esoteric-bounds-of-thing-at-point)
  (unwind-protect
    (apply orig-fun args)
    (advice-remove #'bounds-of-thing-at-point #'esoteric-bounds-of-thing-at-point)))

(advice-add #'highlight-symbol-jump :around #'esoteric-highlight-symbol-jump)

(setq highlight-symbol-colors
   '("yellow" "DeepPink" "cyan" "MediumPurple1" "SpringGreen1" "DarkOrange" "HotPink1" "RoyalBlue1" "green3"))

(provide 'esoteric-highlight-symbol)

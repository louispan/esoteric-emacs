(defvar esoteric-window-switch-list-reset nil
"If nil, then esoteric-window-switch-list-internal will not be reset for the next esoteric-window-switch command")

(defvar esoteric-window-switch-list-internal nil
"During a switch window cycle, this holds the list of windows
to switch into")

;; My own window switching that uses MRU in a modern OS way
(require 'cl-lib)
(defun esoteric-window-list ()
  "Most recently used list of live windows.
Unfixable bug: Recently used order is not accurate if same buffer is displayed in multiple windows."
  (interactive)
  (apply #'append (cl-remove-if #'null
                (mapcar #'get-buffer-window-list (buffer-list)))))

(defun esoteric-window-switch-forward-windows ()
  ;; initialise internal list
  (when (null esoteric-window-switch-list-internal)
    (setq esoteric-window-switch-list-internal (esoteric-window-list)))
  ;; cycle esoteric-window-switch-list-internal forwards
  (let ((head (car esoteric-window-switch-list-internal)))
    (cdr (nconc esoteric-window-switch-list-internal (cons head nil)))))

(defun esoteric-window-switch-backward-windows ()
  (interactive)
  ;; initialise internal list
  (when (null esoteric-window-switch-list-internal)
    (setq esoteric-window-switch-list-internal (esoteric-window-list)))
  ;; cycle esoteric-window-switch-list-internal backwards
  (let ((tail (last esoteric-window-switch-list-internal 1)))
        (append tail (butlast esoteric-window-switch-list-internal 1))))

(defun esoteric-window-switch-forward ()
  (interactive)
  (setq esoteric-window-switch-list-internal (esoteric-window-switch-forward-windows))
  (select-window (car esoteric-window-switch-list-internal)))

(defun esoteric-window-switch-backward ()
  (interactive)
  (setq esoteric-window-switch-list-internal (esoteric-window-switch-backward-windows))
  (select-window (car esoteric-window-switch-list-internal)))

(defun esoteric-window-switch-pre-command-handler ()
  (unless (member this-command '(esoteric-window-switch-forward esoteric-window-switch-backward))
    (setq esoteric-window-switch-list-internal nil)))
(add-hook 'pre-command-hook #'esoteric-window-switch-pre-command-handler)

(provide 'esoteric-window-switch)

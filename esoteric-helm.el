(require 'esoteric-package-install)

;;; Helm
;; http://tuhdo.github.io/helm-intro.html
;; Makes M-x easier to use, fuzzy search and seeing history, ring, mark
(esoteric-package-install 'helm)
(require 'helm-config)

(esoteric-package-install 'helm-ag) ; helm-ag NB. ag is grep
(setq helm-ag-use-grep-ignore-list t)

(esoteric-package-install 'helm-ls-git) ; helm-browse-project

(require 'esoteric-projectile)
 ;; NB. Add .projectile to make any non .git folder into a project
(esoteric-package-install 'helm-projectile) ; helm-projectile-*
(helm-projectile-on) ; replace projectile commands with helm projectile

;; visualize search result in another buffer
(esoteric-package-install 'helm-swoop)
(setq helm-swoop-split-with-multiple-windows t) ; swoop underneath buffer

;;(esoteric-package-install 'helm-flx)

;; company is completion
(esoteric-package-install 'helm-company)

;; Just use the helm way
(defalias 'list-buffers 'helm-buffers-list)

;;https://www.reddit.com/r/emacs/comments/3asbyn/new_and_very_useful_helm_feature_enter_search/
;; Put helm minibuffer on the top, so matches are near it
;; since helm sorts differently from normal bash scripts
(setq helm-echo-input-in-header-line t)
(setq helm-autoresize-mode t)
(setq helm-M-x-always-save-history t)

;; Allow clicking out of helm minibuffer
(setq helm-prevent-escaping-from-minibuffer nil)

(defun esoteric-select-minibuffer-on-helm-window ()
  "If helm candidate buffer is clicked, then automatically select helm minibuffer again"
  (when (eq (get-buffer-window (helm-buffer-get)) (get-buffer-window (car (buffer-list))))
    (esoteric-select-minibuffer)))

(defun esoteric-select-minibuffer ()
  (interactive)
  (let ((buf (cl-remove-if-not #'window-minibuffer-p (window-list))))
    (unless (null buf)
      (select-window (car buf)))))

(add-hook 'buffer-list-update-hook #'esoteric-select-minibuffer-on-helm-window)

;; don't include helm candidate buffer when switching windows
(require 'esoteric-window)
(defun esoteric-nohelm-window-list (orig-fun &rest args)
  (cl-remove-if #'(lambda (buf) (eq (get-buffer-window (helm-buffer-get)) buf)) (apply orig-fun args)))
(advice-add 'esoteric-window-list :around #'esoteric-nohelm-window-list)

;; Also include esoteric-ignored-search-dirs to the boring file list
(require 'esoteric-search-dirs)
(defun esoteric-setup-helm-boring-file-regexp-list ()
  (setq helm-boring-file-regexp-list
    (append
      helm-boring-file-regexp-list
      (mapcar (lambda (d)
        (concat
          (file-name-as-directory ".")
          ;; replace any dots with \\.
          (file-name-as-directory (replace-regexp-in-string "\\." "\\." d nil t))))
      (esoteric-ignored-search-dirs)))))

(add-hook 'helm-mode-hook 'esoteric-setup-helm-boring-file-regexp-list)

;; helm grep ignore directories
(setq helm-walk-ignore-directories
  (append
    helm-walk-ignore-directories
    (mapcar 'file-name-as-directory (esoteric-ignored-search-dirs))))

;; Completes with whatever is selected to be consistent with autocomplete behaviour
;; modified from helm-yank-selection
(defun esoteric-helm-yank-selection ()
  "Set minibuffer contents to current display selection."
  (interactive)
  (with-helm-alive-p
    ;; helm-get-selection with nil nil so I don't get shortcut key annotations
    (let ((str (format "%s" (helm-get-selection nil nil)))
          (start (point)))
      (kill-new str)
      (helm-set-pattern str))))
      ;; only get subword
      ; ;; restore original position
      ; (goto-char start)
      ; (esoteric-forward-word 1)
      ; ;; now delete the rest of the contents
      ; (esoteric-silently-delete-line))))
(put 'esoteric-helm-yank-selection 'helm-only t)

(defun esoteric-setup-helm ()
  (helm-mode t) ; must be after esoteric-helm-key
  ;;"Modify the behavior of `push-mark' to updatethe `global-mark-ring' after each new visit."
  (helm-push-mark-mode t))
(add-hook 'emacs-startup-hook 'esoteric-setup-helm)

;; Start helm-M-x with some initial input.
;; https://groups.google.com/forum/#!topic/emacs-helm/oajEe5ERLkY
(defun esoteric-helm-with (orig-fun str)
  (minibuffer-with-setup-hook
       (lambda () (insert str))
      (call-interactively orig-fun)))

(defun esoteric-helm-internal (orig-fun &rest args)
  "Also prevent helm from disabling cua mode
https://github.com/emacs-helm/helm/blob/38b12a63e045b5adf48f8a1009bba8a16d9c3f03/helm.el#L1902"
  (advice-add #'cua-mode :around #'ignore)
  (unwind-protect
    (apply orig-fun args)
    (advice-remove #'cua-mode #'ignore)))
(advice-add #'helm-internal :around #'esoteric-helm-internal)

;; I like being able to access scratch and other buffers while using helm
(setq helm-split-window-in-side-p t)

;; I have long filenames
(setq helm-buffer-max-length nil)

(defun esoteric-helm-find (arg)
  "Prompt find directory by default"
  (interactive "P")
  (setq prefix-arg (not arg))
  (funcall #'helm-find (not arg)))

;; Add projectile sources to helm-mini
(setq helm-mini-default-sources
      '(helm-source-buffers-list helm-source-recentf helm-source-buffer-not-found helm-source-projectile-files-list helm-source-projectile-projects))

(defun esoteric-helm-copy-to-clipboard ()
  "Copy selection or marked candidates to clipboard.
Note that the real values of candidates are copied and not the
display values."
  (interactive)
  (with-helm-alive-p
    (kill-new (mapconcat
      (lambda (c) (format "%s" c))
      (helm-marked-candidates) "\n"))))

(put 'esoteric-helm-copy-to-clipboard 'helm-only t)

(provide 'esoteric-helm)

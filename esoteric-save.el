;;; Scratch
(require 'esoteric-package-install)
(esoteric-package-install 'persistent-scratch)
(persistent-scratch-setup-default)

;;; Session

;; save cursor position
;; https://www.emacswiki.org/emacs/SavePlace
(require 'saveplace)
(setq save-place-file "~/.emacs.d/saved-place")
(setq-default save-place t)
(setq save-place-forget-unreadable-files nil)

(setq savehist-additional-variables
   (quote
    (tags-file-name
     tags-table-list
     kill-ring
     search-ring
     regexp-search-ring
     extended-command-history
     register-alist
     file-name-history)))

;; Scratch persistence
(defun esoteric-scratch-buffer-p (&optional bufname)
"Scratch buffers must start with *scratch*"
    (string-prefix-p "*scratch*" bufname))

(defun esoteric-persistent-scratch-default-scratch-buffer-p ()
    (esoteric-scratch-buffer-p (buffer-name)))
(advice-add #'persistent-scratch-default-scratch-buffer-p :override #'esoteric-persistent-scratch-default-scratch-buffer-p)

(defun esoteric-save-buffer-or-scratch ()
"Calls save-buffer or persistent-scratch-save"
    (interactive)
    (if (esoteric-scratch-buffer-p (buffer-name))
        (persistent-scratch-save)
        (save-buffer)))

;; Also make sure persistent-scratch-save during save-some-buffers
(defun esoteric-save-some-buffers (&rest ignore)
    (persistent-scratch-save))
(advice-add #'save-some-buffers :before #'esoteric-save-some-buffers)

;; Commenting out as desktop doesn't interact well with daemon mode
;; It seems to use the daemon frame, then quitting then wants to quit daemon
;; ;; Automatically save and restore sessions
;; (setq desktop-dirname           "~/.emacs.d/desktop/"
;;       desktop-base-file-name      "emacs.desktop"
;;       desktop-base-lock-name      "eamcs.lock"
;;       desktop-path                (list desktop-dirname)
;;       desktop-save                t
;;       desktop-files-not-to-save   "^$" ;reload tramp paths
;;       desktop-load-locked-desktop t
;;       desktop-globals-to-save     nil) ; using savehist instead

;; ;; make sure restoring sessions doesn't wipe client frame parameter which
;; ;; is used by quit to detect whether to quit server or just the client
;;(require 'server)
;;(setq frameset-filter-alist (cons '(client . :never) (copy-tree frameset-filter-alist)))

;; (defun esoteric-desktop-make-dirname (&rest ignore)
;;   (when desktop-dirname
;;     (make-directory desktop-dirname t)))
;; (advice-add 'desktop-save :before #'esoteric-desktop-make-dirname)

(defun esoteric-setup-save ()
  ;; ;; don't lock desktop file on the daemon process
  ;; (unless (daemonp)
  ;;   (desktop-save-mode t)
  ;;   (desktop-read))
  (savehist-mode t))
(add-hook 'emacs-startup-hook #'esoteric-setup-save)

;; ;; This hook only get called from a emacsclient
;; (require 'server)
;; (defun esoteric-after-make-frame-desktop-setup (frame)
;;   (when (daemonp) ; just in case
;;     (setq desktop-base-file-name (format "emacs-daemon-%s.desktop" server-name)
;;           desktop-base-lock-name (format "emacs-daemon-%s.lock" server-name))
;;     (desktop-save-mode t)
;;     (desktop-read)))
;; (add-hook 'after-make-frame-functions #'esoteric-after-make-frame-desktop-setup)

(provide 'esoteric-save)

(require 'esoteric-helm)
(require 'esoteric-erase)
(require 'esoteric-ignoring)


;; In helm minibuffer:
;; C-x c is the default key binding for helm-command-prefix-key.
;; M-RET to show actions (was <tab>)
;; S-RET to run action without closing helm (was <C-z>)
;; @word to show files with the word
;; <C-s> to open file with moccur of that word
;; Grep : helm-find-files (optional mark files with ctrl space) <tab> grep
;; helm-mini combines multiple sources
;; helm-occur: grep just in this file
;; helm-resume: resume a previous helm session

;; My custom helm mappings
;; See helm.el 'defvar helm-map'
;; Useful original helm keys
;; https://github.com/emacs-helm/helm/blob/master/helm.el
;; (define-key map (kbd "M-SPC")      'helm-toggle-visible-mark)
;; (define-key map (kbd "M-a")        'helm-mark-all)
;; (define-key map (kbd "M-U")        'helm-unmark-all)
;; (define-key map (kbd "M-m")        'helm-toggle-all-marks)
(require 'esoteric-silent-cua)
(require 'esoteric-motion)

(define-key helm-map (kbd "<right>")    'right-char) ; was 'helm-next-source
(define-key helm-map (kbd "<left>")     'left-char) ; was 'helm-previous-source)
(define-key helm-map (kbd "<S-down>")   'helm-follow-action-forward) ; was C-down
(define-key helm-map (kbd "<S-up>")     'helm-follow-action-backward) ; was C-up
(define-key helm-map (kbd "<M-down>")   'helm-next-source) ; was right
(define-key helm-map (kbd "<M-up>")     'helm-previous-source) ; was left
(define-key helm-map (kbd "<C-down>")   'helm-next-page) ; was 'helm-follow-action-forward
(define-key helm-map (kbd "<C-up>")     'helm-previous-page) ;was 'helm-follow-action-backward
;; NB "C-c C-c" is phyically C-M-c C-M-c due to esoteric-cua-key
(define-key helm-map (kbd "C-c C-c")    'esoteric-helm-copy-to-clipboard) ; copies marked candidates to clipboard
(define-key helm-map (kbd "C-x")        'esoteric-silently-cut-region-or-whole-line) ; new
(define-key helm-map (kbd "C-v")        'esoteric-silently-cua-paste) ; was helm-next-page
(define-key helm-map (kbd "C-z")        'esoteric-silently-undo) ; helm-execute-persistent-action
(define-key helm-map (kbd "C-i")        'esoteric-helm-yank-selection) ; C-i is TAB. Was helm-select-action
(define-key helm-map [(meta return)]    'helm-select-action) ; remapped from <TAB>
(define-key helm-map [(shift return)]   'helm-execute-persistent-action) ; remap from C-z
(define-key helm-map (kbd "S-SPC")      'helm-toggle-visible-mark) ; new to be consistent with the idea of shift is mark/region

;; (define-key helm-find-files-map (kbd "C-c <DEL>") 'esoteric-silently-delete-line-backwards); 'helm-ff-run-toggle-auto-update)
;; (define-key helm-read-file-map (kbd "C-c <DEL>") 'esoteric-silently-delete-line-backwards); 'helm-ff-run-toggle-auto-update)
;; (define-key helm-find-files-map (kbd "C-<backspace>") 'esoteric-silently-delete-line); 'helm-ff-run-toggle-auto-update)
;; (define-key helm-read-file-map (kbd "C-<backspace>") 'esoteric-silently-delete-line); 'helm-ff-run-toggle-auto-update)
(define-key helm-find-files-map (kbd "C-c <DEL>") nil); 'helm-ff-run-toggle-auto-update)
(define-key helm-read-file-map (kbd "C-c <DEL>") nil); 'helm-ff-run-toggle-auto-update)
(define-key helm-find-files-map (kbd "C-<backspace>") nil); 'helm-ff-run-toggle-auto-update)
(define-key helm-read-file-map (kbd "C-<backspace>") nil); 'helm-ff-run-toggle-auto-update)

;; helm tab completion in eshell
;; https://github.com/emacs-helm/helm/wiki/Eshell
(require 'em-cmpl)
(defun esoteric-setup-helm-eshell-complete ()
  (eshell-cmpl-initialize)
  (define-key eshell-mode-map [remap eshell-pcomplete] 'helm-esh-pcomplete)
  (define-key eshell-mode-map (kbd "C-r") 'helm-eshell-history)) ; like fzf bash plugin
(add-hook 'eshell-mode-hook 'esoteric-setup-helm-eshell-complete)

;; NB; in esoteric-quit, M-c can cancel helm minibuffer
(global-set-key (kbd "M-x") #'helm-M-x) ; memenic: e(x)ecute
(global-set-key (kbd "M-r") #'helm-resume) ; memonic: (r)esume

;; helm-mini is a combo of buffer list and recentf
;; NB. C-l is clear screen in term and e-shell, so use M-l for buffer list.
(global-set-key (kbd "M-l") #'helm-mini) ; memonic: buffer (l)ist
(global-set-key (kbd "M-p") #'(lambda () (interactive) (esoteric-helm-with #'helm-M-x "helm-projectile "))) ; memonic: (p)roject commands

;; C-p for project to be consistent with sublime
(global-set-key (kbd "C-p") #'helm-projectile) ; memonic: (P)roject ; was previous-line

;; With any helm grep
;; You and <M-return> to options and save to grep buffer

;; Swoop
;; During isearch M-i to hand the word over to helm-swoop
;; During helm-swoop M-i to hand the word over to helm-multi-swoop-all
;; While doing helm-swoop press C-c C-e to edit mode, apply changes to original buffer by C-x C-s

;; Using fzf-like C-t mapping to find files
(global-set-key (kbd "C-x C-f") nil) ; was find-files, so help shows "C-t" like fzf
(global-set-key (kbd "M-t") nil); NB was transpose-words, I don't like it sometimes does this when I mis remember helm-find-files
(global-set-key (kbd "C-t") #'helm-find-files); NB was transpose-chars

;; C-f/C-S-f for searching like modern IDEs
;; Find files, make it like other IDEs
(global-set-key (kbd "C-f") 'isearch-forward)
(define-key isearch-mode-map (kbd "C-f") 'isearch-repeat-forward)
(global-set-key (kbd "C-S-f") 'isearch-backward)
(define-key isearch-mode-map (kbd "C-S-f") 'isearch-repeat-backward)
(define-key isearch-mode-map (kbd "C-v") 'isearch-yank-pop); normally M-y

;; swoop uses ses C-r/C-S-r like fzf
(global-set-key (kbd "C-r") #'helm-swoop); this searching inside files
(global-set-key (kbd "C-S-r") #'helm-multi-swoop)
(global-set-key (kbd "C-M-S-r") #'helm-multi-swoop-all)

;; NB grep has several options
;; M-x helm-projectile-ag ; requires .projectile or .git in folder
;; M-x rgrep ; doesn't require projects

(provide 'esoteric-helm-key)

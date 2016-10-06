;; My version of cua, to be more like modern IDEs
;; If region is not selected, C-x to cut current line and C-v to copy current line.
;; S-C-x and S-C-c can always be used to emulate C-x and C-c prefix mode.
(require 'esoteric-cua)
(require 'esoteric-erase)

;; cua doesn't select the copy/cut keymaps if region is not selected.
;; C-x and C-c must bind to a prefix map, other emacs will complain when other module
;; Hack around this by swapping C-S-c with C-c, and repeat for C-x

;; http://emacs.stackexchange.com/questions/10681/how-to-set-a-terminal-local-variable-in-all-terminals
;; input-decode-map is a terminal-local variable which need hooking for daemon mode.
;; Hook to with-selected-frame and setup within the frame.
(require 'esoteric-hijackey)
(defun esoteric-change-prefix-keys ()
   (define-key input-decode-map [(control meta c)] [(control c)])
   (define-key input-decode-map [(control c)] [(meta control c)])
   (define-key input-decode-map [(control meta x)] [(control x)])
   (define-key input-decode-map [(control x)] [(meta control x)])
   ;; hijackey keys also use input-decode map, so override the hijackey version
   (define-key input-decode-map "\e[72;99;7~"  [(control c)]) ;; was C-M-c
   (define-key input-decode-map "\e[72;120;7~" [(control x)]) ;; was C-M-x
  )

(defun esoteric-after-make-frame-change-prefix-keys (frame)
  (with-selected-frame frame
    (esoteric-change-prefix-keys)))

(add-hook 'after-make-frame-functions #'esoteric-after-make-frame-change-prefix-keys)

;; change the prefix keys for normal mode and the 1st client
(esoteric-change-prefix-keys)

(global-set-key (kbd "C-a") 'esoteric-mark-whole-buffer)

(defun esoteric-setup-cua-keymaps ()
  (define-key cua--cua-keys-keymap [(meta control x)] 'esoteric-cut-region-or-whole-line)
  (define-key cua--cua-keys-keymap [(meta control c)] 'esoteric-copy-region-or-whole-line)
  (define-key cua-global-keymap (kbd "C-S-M-SPC") 'cua-toggle-global-mark))
(add-hook 'cua-mode-hook 'esoteric-setup-cua-keymaps)

(defun esoteric-cua--select-keymaps (orig-fun &rest args)
  (apply orig-fun args)
  ;; always disable the prefix maps since we just want to use shifted prefix
  (setq cua--ena-prefix-override-keymap nil)
  (setq cua--ena-prefix-repeat-keymap nil))
(advice-add 'cua--select-keymaps :around #'esoteric-cua--select-keymaps)

(provide 'esoteric-cua-key)

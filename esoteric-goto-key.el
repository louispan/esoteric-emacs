(require 'esoteric-goto)

;; I like C-g (keyboard-quit) to mean go to line to be consistent with other IDEs.
;; but C-g is a special key for quitting in emacs.
;; https://www.gnu.org/software/emacs/manual/html_node/emacs/Quitting.html
;; C-g works by setting the variable quit-flag to t the instant C-g is typed;
;; Emacs Lisp checks this variable frequently, and quits if it is non-nil.
;; C-g is only actually executed as a command if you type it while Emacs is waiting for input.
;; In that case, the command it runs is keyboard-quit.
;; Hence it is safe to remap C-g to goto-line. C-g can still be used to quit an infinite loop.
;; When emacs is not hung, it'll run goto-line.
(global-set-key (kbd "C-g") 'goto-line)
(global-set-key (kbd "C-S-g") 'goto-char)
(global-set-key (kbd "M-;") 'avy-goto-word-or-subword-1)

(provide 'esoteric-goto-key);

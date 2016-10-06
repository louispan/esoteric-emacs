;;; Shell
;;http://unix.stackexchange.com/questions/104325/what-is-the-difference-between-shell-eshell-and-term-in-emacs
;; M-x shell  creates *shell* buffer. Stdin buffered until <return>
;; M-x term  creates *terminal* buffer. Stdin no buffering, except C-c
;; while in terminal:
;;   C-c C-c Send a literal C-c to the sub-shell.
;;   C-c C-k Switch to line mode.
;;   C-c C-j Switch to char mode.

;; M-x eshell  creates *eshell* buffer which autocloses on exit. Can send output to emacs (eg echo hello >#<buffer results>).

;; M-x rename-uniquely  renames the current buffer so another shell buffer can be created
;; M-! run shell command, outputs to *Shell Command Output*
;; M-| run shell command using selected text, outputs to *Shell Command Output*

;; http://stackoverflow.com/questions/7733668/command-to-clear-shell-while-using-emacs-shell
;; C-l to clear shell (standard shell command)
(defun eshell-clear-buffer ()
  "Clear eshell"
  (interactive)
  (let ((inhibit-read-only t))
    (erase-buffer)
    (eshell-send-input)))

(provide 'esoteric-eshell)
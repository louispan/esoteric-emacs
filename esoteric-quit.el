(require 'esoteric-save)
;; based on http://stackoverflow.com/questions/234963/re-open-scratch-buffer-in-emacs
(defun esoteric-kill-this-buffer (orig-fun &rest args)
  "Kill this buffer except for *scratch buffers"
    (let ((bufname (buffer-name (current-buffer))))
      (cond
        ((esoteric-scratch-buffer-p bufname)
          (bury-buffer))
        ((string-prefix-p "*Messages*" bufname)
          (bury-buffer))
        (t (apply orig-fun args)))))

(advice-add 'kill-this-buffer :around #'esoteric-kill-this-buffer)

(defun esoteric-save-buffers-kill-terminal-ask ()
  "Ask user before quitting. If quitting will ask to save any modified files."
  (interactive)
  (let ((prompt (yes-or-no-p "Quit?")))
    (when prompt
      (save-buffers-kill-terminal))))

(provide 'esoteric-quit)

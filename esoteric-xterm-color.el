;;; 256 colors
;; http://stackoverflow.com/questions/63950/how-to-make-emacs-terminal-colors-the-same-as-emacs-gui-colors
;; https://www.xvx.ca/~awg/emacs-colors-howto.txt

;; Manual install requirements:
;; In bash:
;; sudo apt-get install ncurses-term
;; export TERM=xterm-256color # or hardcode in .bashrc or terminal app

;; Tests
;; In bash:
;; tput colors   # should print 256
;; In emacs:
;; M-x list-colors-display

;; https://github.com/atomontage/xterm-color
(require 'esoteric-package-install)
(esoteric-package-install 'xterm-color)

(setq ansi-color-for-comint-mode nil)

;;; Use xterm-color-unfontify-region-23 on Emacs 23.x

;; comint install
(progn (add-hook 'comint-preoutput-filter-functions 'xterm-color-filter)
       (setq comint-output-filter-functions (remove 'ansi-color-process-output comint-output-filter-functions))
       (setq font-lock-unfontify-region-function 'xterm-color-unfontify-region))

;; Also set TERM accordingly (xterm-256color)

;; You can also use it with eshell (and thus get color output from system ls):
(require 'eshell)

(add-hook 'eshell-mode-hook
          (lambda ()
            (setq xterm-color-preserve-properties t)))

(add-to-list 'eshell-preoutput-filter-functions 'xterm-color-filter)
(setq eshell-output-filter-functions (remove 'eshell-handle-ansi-color eshell-output-filter-functions))

;;  Don't forget to setenv TERM xterm-256color

;; fix for xterm-color package breakages
;; https://github.com/syl20bnr/spacemacs/issues/7393
(fset 'xterm-color-unfontify-region 'font-lock-default-unfontify-region)

(provide 'esoteric-xterm-color)

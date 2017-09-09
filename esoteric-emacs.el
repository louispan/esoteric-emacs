;;; esoteric-emacs.el --- Modern IDE key bindings and configuration for Emacs.

;; Copyright (C) 2016 Louis Pan
;; Author: Louis Pan <louis@pan.me>
;; Keywords: convenience, tools, extensions
;; Homepage: https://github.com/louispan/hijackey-emacs

;; This file is not part of GNU Emacs.

;;; Commentary:
;;

;;; Code:

;; This feature first loads all the esoteric settings
;; If you don't want all the settings, then you can pick and 'require' the
;; just the ones you want
(require 'esoteric-package-install)

; Utils
(require 'esoteric-hijackey)
(require 'esoteric-ignoring)
(require 'esoteric-echo-keys)
(require 'esoteric-search-dirs)

(require 'esoteric-mode-line)

;;; Visual
(require 'esoteric-visual)
(require 'esoteric-xterm-color) ; Add color to shell and eshell

;; Usability tweaks
(require 'esoteric-tweaks)
(require 'esoteric-recentf-key)

;; Clear eshell with C-l
(require 'esoteric-eshell-key)

;; Swap OSX ctrl/cmd
(require' esoteric-osx-key)

;; Helm makes M-x easier to use, for quickly getting to any commands or search
;; Equivalent to unite.vim
(require 'esoteric-helm-key)

;; Navigation
(require 'esoteric-mouse-key)
(require 'esoteric-mark-key)
(require 'esoteric-goto-key)
(require 'esoteric-motion-key)
(require' esoteric-highlight-symbol-key)
(require 'esoteric-window-key)

;; Editing
(require 'esoteric-macro-key)
(require 'esoteric-autorevert)
(require 'esoteric-cua-key) ; C-x cut, C-v paste, C-z undo
(require 'esoteric-indent-key)
(require 'esoteric-undo-key)
(require 'esoteric-open-line-key)
(require 'esoteric-erase-key)
(require 'esoteric-replace-key)

;; Programming
(require' esoteric-completion-key)
(require 'esoteric-commenter-key)
(require 'esoteric-snippets-key)
(esoteric-package-install 'magit)
(require 'esoteric-flycheck)

;; Other shortcut keys
(require 'esoteric-suspend-key)
(require 'esoteric-quit-key)
;;; Session persistance and saving files
(require 'esoteric-save-key)

;; Haskell
(require 'esoteric-haskell-key)
(require 'esoteric-python-key)
(require 'esoteric-vimrc)

;; Misc
(require 'esoteric-yaml-key)
(require 'server)
(setq server-use-tcp t)
(require 'tramp)
(setq tramp-default-method "ssh")

;; Other settings you may want to manually add to your .emacs
;; (esoteric-package-install 'zenburn-theme)
;; (load-theme 'zenburn)
;; ;; zenburn region is too hard to see
;; (face-spec-set 'region '((t (:background "#2247c4"))))
;; (sml/setup)
;; ;; (esoteric-distinct-fringe-with 0.05)
;; ;; (esoteric-fix-region-distant-foreground)

;; Generally useful keys & functions
;;
;; <F1> is same as C-h
;; <F1> b    view key binding
;; <F1> v    view variable
;; <F1> f    view function
;; <F1> k    view key sequence
;; <F1> m    view mode
;; <F1> a    apropos - search for commmands
;; <S-f10>   toggle enabling menu (This is an esoteric mapping)
;; <f10>    open menu

;; M-x      evaluate function
;; M-:      evaluate arbitrary elisp (eval-expression)
;; C-j      evaluate selected text as elisp

;; Quiting
;; C-x C-c (save-buffers-kill-terminal) Quit emac
;; <ESC> <ESC> <ESC> (keyboard-escape-quit)
;; M-c Abort partially typed command 'keyboard-quit' (was C-g before esoteric changes)

;; In cua mode:
;; shift-arrow  selects
;; ctrl-space  sticky normal select
;; alt-enter  block selects (customised cua-rectangle-mark-key)

;; (global-unset-key key) ; to unset a keybinding

;; https://www.emacswiki.org/emacs/EmacsNewbieWithIcicles
;; ‘M-x top-level’ to get back to the top level of Emacs, after being submerged in a recursive edit session. Use this if you see [...] (or [[...]], and so on) in the ModeLine.
;; Use ‘C-h l’ to see what the last 300 keys you typed were (this includes mouse and menu actions; in Emacs, “key” is pretty general). Use this to try to figure out how you got into the mess that you’re in!

;; Rename open buffers by:
;; M-x dired-jump
;; then in dired-mode
;; R to rename
;; M-x dired-summary or ? in dired-mode for other commands

;; Tramp: Allow editing over ssh
;; C-x C-f /remotehost:filename  RET (or /method:user@remotehost:filename)
;; Or as root:
;; C-x C-f /su::/etc/hosts
;; C-x C-f /sudo::/etc/hosts

;; Emacs in daemon mode
;; http://www.tychoish.com/posts/running-multiple-emacs-daemons-on-a-single-system/
;; (setq server-use-tcp t) ; in order for multiple servers
;; Start default server:
;; emacs --daemon
;; Start named server:
;; eamcs --daemon=foo
;; https://www.emacswiki.org/emacs/EmacsClient
;; To run a daemon automatically use:
;; --alternate-editor=""
;; Connect to default daemon
;; emacsclient --alternate-editor="" -c "$@"
;; Connect to named daemon
;; emacsclient --alternate-editor="" -f foo -c "$@"
;; emacsclient --alternate-editor="" --server-file=foo -c "$@"

(provide 'esoteric-emacs)

;;; esoteric-emacs.el ends here

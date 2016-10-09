Opinionated emacs scripts to make emacs "easier" to use, by following modern IDE/editor bindings.

Uses hijackey-emacs (https://github.com/louispan/hijackey-emacs) to enable more key combinations in terminal.

# Usability changes

* Ctrl-X is cut, Ctrl-V is paste, Ctrl-C is copy (cua-binding enabled). Cua-bindings have been modified to also cut/copy the line if nothing is selected.
See esoteric-xxx-key.el for other key bindings.

* Alt-X brings up an interactive emacs command selection using helm.

# Installation

Put the following in your `.emacs`

```
(package-initialize)

(unless (require 'quelpa nil t)
  (with-temp-buffer
    (url-insert-file-contents "https://raw.github.com/quelpa/quelpa/master/bootstrap.el")
    (eval-buffer)))

(unless (require 'esoteric-emacs nil t)
    (quelpa '(esoteric-emacs :repo "louispan/esoteric-emacs" :fetcher github))
    (require 'esoteric-emacs))
```
See https://github.com/louispan/esoteric/blob/master/etc/.emacs for an example.

# Customisation

It should be possible to customize the key bindings by not `require`-ing esoteric-emacs.el and `require` your own selection of esoteric and your own custom emacs keybindings/scripts.

# Note

* Mode specific prefix (normally Ctrl-C) is remapped to Ctrl-Alt-C and global prefix (normallyu Ctrl-X) is remapped to Ctrl-Alt-X.

* Cancel (normally Ctrl-G) has been remapped to Alt-C, since Ctrl-G has been remapped to `goto-line`. However, Ctrl-G is still special and must be used to cancel out of hanging emacs.

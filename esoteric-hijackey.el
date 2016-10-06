(require 'esoteric-package-install)

(unless (require 'hijackey-emacs nil t)
    (quelpa '(hijackey-emacs :repo "louispan/hijackey-emacs" :fetcher github))
    (require 'hijackey-emacs))

(provide 'esoteric-hijackey)

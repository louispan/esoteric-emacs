(require 'esoteric-package-install)
(require 'esoteric-snippets)

(esoteric-package-install 'haskell-snippets)

;; new - newtype
;; mod - module [simple, exports]
;; main - main module and function
;; let - let bindings
;; lang - language extension pragmas
;; opt - GHC options pragmas
;; \ - lambda function
;; inst - instance declairation
;; imp - import modules [simple, qualified]
;; if - if conditional [inline, block]
;; <- - monadic get
;; fn - top level function [simple, guarded, clauses]
;; data - data type definition [inline, record]
;; => - type constraint
;; {- - block comment
;; case - case statement

(provide 'esoteric-haskell-snippets)

;; `C-x (’ or <f3>– start defining a keyboard macro
;; C-x )’ or <f4>– stop defining the keyboard macro
;; ‘C-x e’ or <f4> – execute the keyboard macro
;; Here’s how to execute the macro 37 times (you use ‘C-u’ to provide the 37):
;; ‘C-u 37 C-x e’
;; C-u (   Re-execute last keyboard macro, then append keys to its definition.
;; C-u C-u (   Append keys to the last keyboard macro without re-executing it.
;; C-x C-k r  Run the last keyboard macro on each line that begins in the region (apply-macro-to-region-lines).
;; C-x q   When this point is reached during macro execution, ask for confirmation (kbd-macro-query).

(provide 'esoteric-macro-key)

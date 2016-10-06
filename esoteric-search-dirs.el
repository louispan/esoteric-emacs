;; Copied from http://ergoemacs.org/emacs/elisp_read_file_content.html
(defun esoteric-read-lines (filePath)
  "Return a list of lines of a file at filePath."
  (with-temp-buffer
    (insert-file-contents filePath)
    (split-string (buffer-string) "\n" t)))

(defun esoteric-ignored-search-dirs ()
    "Returns a list of dirs from the file named by the environment variable SEARCH_DIRS_IGNORE_FILE"
    (let* ((ignore-file-env (getenv "SEARCH_DIRS_IGNORE_FILE"))
           (ignore-file (if (string= "" ignore-file-env)
              (expand-file-name "~/.search_dirs.ignore")
              ignore-file-env)))
        (condition-case nil
            (esoteric-read-lines ignore-file)
          (error nil))))

;; grep ignore directories
;; M-x rgrep is the easier one to use
(require 'grep)
(setq grep-find-ignored-directories
   (append grep-find-ignored-directories (esoteric-ignored-search-dirs)))

(provide 'esoteric-search-dirs)

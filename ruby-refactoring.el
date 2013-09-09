;;; Very simple refactoring code for Ruby-mode

(defvar rrf-refactored-method-name nil)
(defvar rrf-refactored-method-body nil)

(defun rrf-extract-method (method-name args beg end)
  (interactive "sMethod Name: \nsArgs: \nr")
  (if (string= "" args)
      (setq rrf-refactored-method-name method-name)
    (setq rrf-refactored-method-name
          (concat method-name "(" args ")")))
  (setq rrf-refactored-method-body (buffer-substring beg end))
  (kill-region beg end)
  (insert-string rrf-refactored-method-name)
  (indent-according-to-mode)
  (paredit-newline))

(defun rrf-insert-extracted-method ()
  (interactive)
  (insert-string "def ")
  (insert-string rrf-refactored-method-name)
  (indent-according-to-mode)
  (insert-string "\n")
  (insert-string rrf-refactored-method-body)
  (indent-region (mark) (point))
  (insert-string "end")
  (indent-according-to-mode)
  (insert-string "\n"))

(require 'ruby-mode)
(define-key ruby-mode-map "\C-cam" 'rrf-extract-method)
(define-key ruby-mode-map "\C-cay" 'rrf-insert-extracted-method)

;;; Very simple refactoring code for Ruby-mode

;;; These are some very simple minded Ruby refactoring functions.
;;; They perform almost no syntax analsys (and therefore depend on the
;;; user doing the right thing), but are quite useful nevertheless.
;;;
;;; The extraction style refactorings work by marking the code to be
;;; extracted into a method, constant, or temp variable. Then the user
;;; runs the desired extraction method (e.g. rrf-extract-constant).
;;; Then the user moves the cursor to the location the extracted code
;;; will be inserted and runs the generic insert function
;;; (rrf-insert-extraction, generally bound to "C-Cay").

;;; Globals used by the refactorings

(defvar rrf-insertion-method nil)
(defvar rrf-refactored-const-body nil)
(defvar rrf-refactored-const-name nil)
(defvar rrf-refactored-method-body nil)
(defvar rrf-refactored-method-name nil)
(defvar rrf-refactored-var-body nil)
(defvar rrf-refactored-var-name nil)

(defvar rrf-non-id-pattern "[^A-Za-z0-9_]")

;;; Top-level refactoring functions

(defun rrf-extract-temporary (var-name beg end)
  "Extract an expression into a temporary variable."
  (interactive "sVariable Name: \nr")
  (setq rrf-refactored-var-name var-name)
  (setq rrf-refactored-var-body (buffer-substring beg end))
  (rrf-replace-region beg end rrf-refactored-var-name)
  (goto-char beg)
  (move-beginning-of-line 1)
  (open-line 1)
  (rrf-insert-named-expression rrf-refactored-var-name rrf-refactored-var-body)
  (setq rrf-insertion-method nil))

(defun rrf-extract-constant (const-name beg end)
  "Extract an expression into a constant."
  (interactive "sConstant Name: \nr")
  (setq rrf-refactored-const-name const-name)
  (setq rrf-refactored-const-body (buffer-substring beg end))
  (rrf-replace-region beg end rrf-refactored-const-name)
  (setq rrf-insertion-method 'rrf-insert-extracted-constant))

(defun rrf-insert-extracted-constant ()
  "Insert the definition for a previously extracted constant."
  (interactive)
  (rrf-insert-named-expression rrf-refactored-const-name rrf-refactored-const-body))

(defun rrf-extract-method (method-name args beg end)
  "Extract a method."
  (interactive "sMethod Name: \nsArgs: \nr")
  (if (string= "" args)
      (setq rrf-refactored-method-name method-name)
    (setq rrf-refactored-method-name
          (concat method-name "(" args ")")))
  (setq beg (rrf-adj-beg beg end)
        end (rrf-adj-endl beg end))
  (setq rrf-refactored-method-body (buffer-substring beg end))
  (rrf-replace-region beg end rrf-refactored-method-name)
  (setq rrf-insertion-method 'rrf-insert-extracted-method))

(defun rrf-insert-extracted-method ()
  "Insert the definition for a previously extracted method."
  (interactive)
  (let ((b nil) (e nil))
    (insert-string "def ")
    (insert-string rrf-refactored-method-name)
    (indent-according-to-mode)
    (insert-string "\n")
    (setq b (point))
    (insert-string rrf-refactored-method-body)
    (setq e (point))
    (indent-region b e)
    (insert-string "\nend")
    (indent-according-to-mode)
    (insert-string "\n")))

(defun rrf-insert-extraction ()
  "Insert the last thing that was extracted."
  (interactive)
  (if rrf-insertion-method
      (funcall rrf-insertion-method))
  (setq rrf-insertion-method nil))

(defun rrf-inline-variable-definition (beg end)
  "Inline the variable being defined by the expression in the region."
  (interactive "r")
  (setq beg (rrf-adj-beg beg end))
  (setq end (rrf-adj-endl beg end))
  (goto-char beg)
  (re-search-backward "[A-Za-z0-9_?!] *= *")
  (setq rrf-refactored-var-name (rrf-word-string))
  (setq rrf-refactored-var-body (buffer-substring beg end))
  (move-beginning-of-line 1)
  (let ((here (point)))
    (kill-region here (+ 1 end))
    (mark-defun)
    (goto-char here)
    (query-replace-regexp
     rrf-refactored-var-name
     rrf-refactored-var-body
     t
     here (mark))))

;;; Utility Functions

(defun rrf-replace-region (beg end replacement)
  "Replace the region with REPLACEMENT"
  (goto-char beg)
  (kill-region beg end)
  (insert-string replacement)
  (indent-according-to-mode))

(defun rrf-insert-named-expression (name expression)
  "Insert NAME = EXPRESSION."
  (insert-string name)
  (indent-according-to-mode)
  (insert-string " = ")
  (insert-string expression)
  (indent-region (mark) (point)))

(defun rrf-adj-beg (beg end)
  "Get the adjusted beginning of the region."
  (if (< beg end) beg end))

(defun rrf-adj-end (beg end)
  "Get the adjusted ending of the region."
  (if (> beg end) beg end))

(defun rrf-adj-endl (beg end)
  "Get the adjusted ending of the region, forced to the end of line."
  (let ((newend (rrf-adj-end beg end)))
    (if (rrf-first-column-p newend)
        (- newend 1)
      newend)))

(defun rrf-first-column-p (loc)
  "Is LOC in the first column?"
  (or (= 0 loc)
      (save-excursion
        (goto-char (- loc 1))
        (looking-at "\n"))))

(defun rrf-beginning-of-word ()
  "Find the beginning of the word at point."
  (save-excursion
    (re-search-backward rrf-non-id-pattern)
    (+ (point) 1)))

(defun rrf-end-of-word ()
  "Find the beginning of the word at point."
  (save-excursion
    (re-search-forward rrf-non-id-pattern)
    (- (point) 1)))

(defun rrf-word-string ()
  "Return the identifier (as a string) on point."
  (buffer-substring (rrf-beginning-of-word) (rrf-end-of-word)))

;;; Debugging

(defun rrfx (beg end)
  "Insert the beg/end of the adjusted region (for debugging)."
  (interactive "r")
  (insert-string (rrf-adj-beg beg end))
  (insert-string ",")
  (insert-string (rrf-adj-endl beg end))
  (insert-string "\n"))

;;; Key bindings

(require 'ruby-mode)
(define-key ruby-mode-map "\C-cac" 'rrf-extract-constant)
(define-key ruby-mode-map "\C-cat" 'rrf-extract-temporary)
(define-key ruby-mode-map "\C-cam" 'rrf-extract-method)
(define-key ruby-mode-map "\C-cay" 'rrf-insert-extraction)
(define-key ruby-mode-map "\C-cait" 'rrf-inline-variable-definition)

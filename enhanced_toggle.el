;;; -- Toggle Enhancements -------------------------------------------

(require 'find-in-parent-dir)
(require 'toggle)

;;; Note that we have switched the order of test/code files in these
;;; rules.  This allows the lib/*.rb rules to work properly.

(defun add-toggle-mapping (mapping)
  (setq toggle-mapping-styles
        (assq-delete-all (car mapping) toggle-mapping-styles))
  (add-to-list 'toggle-mapping-styles mapping))

(add-toggle-mapping
 '(jw-rails
   ("test/functional/\\1_test.rb"   . "app/controllers/\\1.rb")
   ("test/unit/helpers/\\1_test.rb" . "app/helpers/\\1.rb")
   ("test/unit/lib/\\1_test.rb"     . "lib/\\1.rb" )
   ("test/unit/\\1_test.rb"         . "app/models/\\1.rb")))

(add-toggle-mapping
 '(jw-rails-spec
   ("spec/\\1_spec.rb"              . "app/\\1.rb")))

(add-toggle-mapping
 '(jw-spec
   ("spec/\\1_spec.rb"         . "lib/\\1.rb")
   ("\\1_spec.rb"              . "\\1.rb")))

(add-toggle-mapping
 '(jw-postfix
   ("test/\\1_test.rb" . "lib/\\1.rb")
   ("\\1_test.rb"      . "\\1.rb")))

(add-toggle-mapping
 '(jw-prefix
   ("test/test_\\1.rb" . "lib/\\1.rb")
   ("test_\\1.rb"      . "\\1.rb")))

(toggle-style 'jw-postfix)

;;; Debugging ========================================================

(defun toggle-debug-loop (path rules)
  "Search the lookup rules for a toggle match displaying debug statements as you go."
  (cond ((null rules)
         (insert "END OF RULES\n")
         nil)
        ((string-match (caar rules) path)
         (insert (concat "Matching Rule: " (caar rules) "\n"))
         (let ((result (replace-match (cdar rules) nil nil path)))
           (insert "RESULT: " result)
           result) )
        (t
         (insert (concat "Failing  Rule: " (caar rules) "\n"))
         (toggle-debug-loop path (rest rules)))))

(defun toggle-debug (path)
  "Same as the standard toggle-filename, but prints debug messages."
  (interactive "fFile Name: ")
  (pop-to-buffer (set-buffer (get-buffer-create "*dbg*")))
  (goto-char (point-max))
  (insert "\n*************************************\n\n")
  (insert (format "LOOKING FOR %s\n" path))
  (insert (format "IN RULES %s\n\n" toggle-mappings))
  (toggle-debug-loop path toggle-mappings))

;;; --------------------------------------------------------------------------

(defvar etog-toggle-style nil
"Buffer local variable describing the buffer's toggle style.")
(make-variable-buffer-local 'etog-toggle-style)

(defun etog-load-project-toggle-style ()
  "Set the buffer's toggle style from the project defaults."
  (let* ((togglerc (jw-find-in-parent-dir (buffer-file-name) ".togglerc")))
    (if (file-readable-p togglerc)
        (load-file togglerc))
    (if (null etog-toggle-style)
        (setq etog-toggle-style toggle-mapping-style))  ))

(defun etog-select-buffer-toggle-style ()
  "Set the buffer's toggle style.
If no style is currently selected, load the style from the
project .togglerc file."
  (if (null etog-toggle-style)
      (etog-load-project-toggle-style) )
  (setq toggle-mappings (toggle-style etog-toggle-style)) )

(defun etog-toggle-buffer ()
  "Enhanced version of the Ryan Davis's toggle-buffer function
Check for a .togglerc file at the top level of the project
directory.  If found, the file will be loaded before toggling,
allowing per-project toggle customizations."
  (interactive)
  (etog-select-buffer-toggle-style)
  (toggle-buffer) )

(defun etog-clear-buffer-styles ()
  "Clear all the buffer toggle style settings."
  (interactive)
  (let ((buffers (buffer-list)))
    (while buffers
      (if (local-variable-p 'etog-toggle-style (car buffers))
          (save-current-buffer
            (set-buffer (car buffers))
            (setq etog-toggle-style nil) ))
      (setq buffers (cdr buffers)) )
    (message "All buffer toggle styles are reset") ))

(defun etog-add-or-replace (name pair)
  (let* ((key (car pair))
         (new-value (cdr pair))
         (alist (eval name))
         (old-pair (assoc key alist)))
    (cond ((null old-pair) (add-to-list name pair))
          ((equal (cdr old-pair) new-value) ())
          (t (set name (cons pair (assq-delete-all key alist)))) ))
  (eval name) )

(defun etog-test-buffer-p ()
  "Is the current buffer a test?"
  (string-match "_test\." (buffer-name)))

(defun etog-spec-buffer-p ()
  "Is the current buffer a spec?"
  (string-match "_spec\." (buffer-name)))

(defun etog-test-or-spec-buffer-p ()
  "Is the current buffer a runnable specification file of some type?"
  (or (etog-test-buffer-p)
      (etog-spec-buffer-p)))

(defun etog-code-test-split ()
  "Horizontally split between the code and test"
  (interactive)
  (delete-other-windows)
  (if (etog-test-or-spec-buffer-p)
      (etog-toggle-buffer))
  (split-window-horizontally)
  (other-window 1)
  (etog-toggle-buffer)
  (other-window 1))

(defun etog-split-or-toggle (n)
  "Toggle code/test buffer, or split windows with code and test (if prefix)"
  (interactive "P")
  (cond ((null n) (etog-toggle-buffer))
        (t (etog-code-test-split))))

;;; .togglerc specific functions -------------------------------------

;; The following functions are intended to be used in the project
;; specific .togglerc file.
;;
;; Example -- Set the style only:
;;
;;   (buffer-toggle-style 'jw-rails)
;;
;; Example -- Define a mapping and then select it:
;;
;;   (buffer-toggle-mapping
;;    '(project-style    . (("test/\\1_test.rb" . "lib/\\1.rb")
;;                           ("\\1_test.rb"      . "\\1.rb") )))
;;   (buffer-toggle-style 'project-style)

(defun buffer-toggle-style (style-name)
  "Set the testing toggle style for this buffer.
Normally called in the .togglerc file at the project level."
  (setq etog-toggle-style style-name) )

(defun buffer-toggle-mapping (mapping)
  "Define a project specific mapping.
Note: Make sure the mapping name is unique and doesn't class with
mappings from other projects."
  (etog-add-or-replace 'toggle-mapping-styles mapping))

;;; Add the toggle command to the compilation mode, just make it
;;; delete the test buffer.

(defun etog-kill-test-buffer ()
  (interactive)
  (kill-buffer jw-test-buffer-name)
  (if jw-test-last-test-buffer
      (pop-to-buffer jw-test-last-test-buffer) ))


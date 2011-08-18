;;; Put stuff here until we decide what to do with it.

(defun jw-test-toggle-warnings ()
  "Toggle the 'use warnings' flag for when testing"
  (interactive)
  (setq jw-test-warnings (not jw-test-warnings))
  (if jw-test-warnings
      (message "Warnings enabled in tests")
    (message "Warnings disabled in tests") ))


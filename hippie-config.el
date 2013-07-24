;; Hippie expand: at times perhaps too hip

(dolist (f '(try-expand-line try-expand-list try-complete-file-name-partially try-complete-file-name))
  (setq hippie-expand-try-functions-list (delete f hippie-expand-try-functions-list)))

;; Add this back in at the end of the list.
(add-to-list 'hippie-expand-try-functions-list 'try-complete-file-name-partially t)
(add-to-list 'hippie-expand-try-functions-list 'try-complete-file-name t)

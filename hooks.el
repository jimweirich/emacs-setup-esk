;;; Some hooks

;;; Disable the highlight hook.
(add-hook 'coding-hook (lambda () (idle-highlight-mode nil)))

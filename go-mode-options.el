(defun go-custom ()
  "go-mode-hook"
  (set (make-local-variable 'tab-width) 4))

(add-hook 'go-mode-hook
          '(lambda () (go-custom)))

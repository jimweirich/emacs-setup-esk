(defun use-pretty-lambdas ()
  (interactive)
  (add-hook 'coding-hook 'pretty-lambdas))

(defun use-ugly-lambdas ()
  (interactive)
  (remove-hook 'coding-hook 'pretty-lambdas))

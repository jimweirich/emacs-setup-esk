(defun refresh-buffer ()
  "Refresh the current buffer from disk"
  (interactive)
  (revert-buffer t t))

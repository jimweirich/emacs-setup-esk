(defun refresh-buffer ()
  "Refresh the current buffer from disk"
  (interactive)
  (let ((fn (buffer-file-name))
	(lineno (count-lines 1 (point))))
    (kill-buffer (current-buffer))
    (find-file fn)
    (goto-line lineno)))

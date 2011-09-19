(defun ruby-eval-buffer ()
  "Evaluate the current buffer and display the result in a buffer."
  (interactive)
  (save-buffer)
  (let* ((file-name (buffer-file-name (current-buffer)))
         (command (concat "ruby19 " file-name)))
    (shell-command-on-region (point-min) (point-max) command "*RUBY*" nil)
    (pop-to-buffer "*RUBY*")
    (other-window 1)))

(defun ruby-clear-eval-buffer ()
  (interactive)
  (save-excursion
    (set-buffer "*RUBY*")
    (kill-region (point-min) (point-max))))

(defun ruby-eval-or-clear-buffer (n)
  (interactive "P")
  (cond ((null n) (ruby-eval-buffer))
        (t (ruby-clear-eval-buffer)))  )

(defconst jw-ruby-eval-command "/Users/jim/local/bin/ruby19")

(defun ruby-eval-buffer ()
  "Evaluate the current buffer and display the result in a buffer."
  (interactive)
  (save-buffer)
  (let* ((file-name (buffer-file-name (current-buffer)))
         (command (concat jw-ruby-eval-command " " file-name)))
    (shell-command-on-region (point-min) (point-max) command "*RUBY*" nil)
    (pop-to-buffer "*RUBY*")
    (other-window 1)
    (ruby-eval-pretty-up-errors "*RUBY*")
    (message "..")))

(defun ruby-eval-pretty-up-errors (buffer)
  "Fix up the buffer to highlight the error message (if it contains one)."
  (save-excursion
    (set-buffer "*RUBY*")
    (goto-char (point-min))
    (let ((pos (search-forward-regexp "\\.rb:[0-9]+:\\(in.+:\\)? +" (point-max) t)))
      (if pos (progn
                (goto-char pos)
                (insert-string "\n\n")
                (end-of-line)
                (insert-string "\n"))))))

(defun ruby-clear-eval-buffer ()
  (interactive)
  (save-excursion
    (set-buffer "*RUBY*")
    (kill-region (point-min) (point-max))))

(defun ruby-eval-or-clear-buffer (n)
  (interactive "P")
  (cond ((null n) (ruby-eval-buffer))
        (t (ruby-clear-eval-buffer)))  )

(add-hook 'ruby-mode-hook
          '(lambda ()
             (define-key ruby-mode-map "\C-cv" 'ruby-eval-or-clear-buffer)))

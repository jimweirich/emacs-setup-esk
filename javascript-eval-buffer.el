(defconst jw-javascript-eval-command "/usr/local/bin/node")

(defun javascript-eval-buffer ()
  "Evaluate the current buffer and display the result in a buffer."
  (interactive)
  (save-buffer)
  (let* ((file-name (buffer-file-name (current-buffer)))
         (command (concat jw-javascript-eval-command " " file-name)))
    (shell-command-on-region (point-min) (point-max) command "*JAVASCRIPT*" nil)
    (pop-to-buffer "*JAVASCRIPT*")
    (other-window 1)
    (message "..")))

(defun javascript-clear-eval-buffer ()
  (interactive)
  (save-excursion
    (set-buffer "*JAVASCRIPT*")
    (kill-region (point-min) (point-max))))

(defun javascript-eval-or-clear-buffer (n)
  (interactive "P")
  (cond ((null n) (javascript-eval-buffer))
        (t (javascript-clear-eval-buffer)))  )

(add-hook 'js-mode-hook
          '(lambda ()
             (define-key js-mode-map "\C-cv" 'javascript-eval-or-clear-buffer)))

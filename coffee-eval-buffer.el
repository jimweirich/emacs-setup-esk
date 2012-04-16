(defconst jw-coffee-eval-command "/usr/local/bin/coffee")

(defun coffee-eval-buffer ()
  "Evaluate the current buffer and display the result in a buffer."
  (interactive)
  (save-buffer)
  (let* ((file-name (buffer-file-name (current-buffer)))
         (command (concat jw-coffee-eval-command " " file-name)))
    (shell-command-on-region (point-min) (point-max) command "*COFFEE*" nil)
    (pop-to-buffer "*COFFEE*")
    (other-window 1)
    (message "..")))

(defun coffee-clear-eval-buffer ()
  (interactive)
  (save-excursion
    (set-buffer "*COFFEE*")
    (kill-region (point-min) (point-max))))

(defun coffee-eval-or-clear-buffer (n)
  (interactive "P")
  (cond ((null n) (coffee-eval-buffer))
        (t (coffee-clear-eval-buffer)))  )

(add-hook 'coffee-mode-hook
          '(lambda ()
             (define-key coffee-mode-map "\C-cv" 'coffee-eval-or-clear-buffer)))

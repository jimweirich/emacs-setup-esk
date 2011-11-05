(defconst jw-clojure-eval-command "/Users/jim/local/bin/clojure")

(defun clojure-eval-buffer ()
  "Evaluate the current buffer and display the result in a buffer."
  (interactive)
  (save-buffer)
  (let* ((file-name (buffer-file-name (current-buffer)))
         (command (concat jw-clojure-eval-command " " file-name)))
    (shell-command-on-region (point-min) (point-max) command "*CLOJURE*" nil)
    (pop-to-buffer "*CLOJURE*")
    (other-window 1)
    (message "..")))

(defun clojure-clear-eval-buffer ()
  (interactive)
  (save-excursion
    (set-buffer "*CLOJURE*")
    (kill-region (point-min) (point-max))))

(defun clojure-eval-or-clear-buffer (n)
  (interactive "P")
  (cond ((null n) (clojure-eval-buffer))
        (t (clojure-clear-eval-buffer)))  )

(add-hook 'clojure-mode-hook
          '(lambda ()
             (define-key clojure-mode-map "\C-cv" 'clojure-eval-or-clear-buffer)))

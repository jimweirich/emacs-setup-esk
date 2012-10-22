(defun pretty-fn-off ()
  (interactive)
  (remove-hook 'clojure-mode-hook 'esk-pretty-fn)
  (clojure-mode)
  (save-excursion
    (goto-char 0)
    (replace-string "fn" "fn")))

(defun pretty-fn-on ()
  (interactive)
  (add-hook 'clojure-mode-hook 'esk-pretty-fn))

(defun pretty-lambdas-p ()
  (member 'esk-pretty-lambdas prog-mode-hook))

(defun toggle-pretty-lambdas ()
  (interactive)
  (if (pretty-lambdas-p)
      (remove-hook 'prog-mode-hook 'esk-pretty-lambdas)
    (add-hook 'prog-mode-hook 'esk-pretty-lambdas))
  (message (concat "Pretty lambdas are " (if (pretty-lambdas-p) "ON" "OFF"))))

(remove-hook 'clojure-mode-hook 'esk-pretty-fn)

(global-set-key (kbd "C-C p +") 'pretty-fn-off)
(global-set-key (kbd "C-C p -") 'pretty-fn-on)

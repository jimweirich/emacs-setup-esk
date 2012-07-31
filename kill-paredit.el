(defun esk-paredit-nonlisp ()
  "Override the ESK desire to turn on paredit for non-lisp."
  (set (make-local-variable 'paredit-space-delimiter-chars)
       (list ?\"))
  (paredit-mode 0))

;; (eval-after-load 'js
;;   '(progn (define-key js-mode-map "{" 'self-insert-command)
;;           (define-key js-mode-map "}" 'self-insert-command)
;;           ;; fixes problem with pretty function font-lock
;;           (define-key js-mode-map (kbd ",") 'self-insert-command)))

(require 'coffee-mode)

(defun coffee-custom ()
  "coffee-mode-hook"
  (set (make-local-variable 'tab-width) 2))

(add-hook 'coffee-mode-hook
          '(lambda () (coffee-custom)))

(defun jw-indent-block (n)
  (interactive "p")
  (indent-rigidly (region-beginning) (region-end) (* tab-width n)))

(defun jw-outdent-block (n)
  (interactive "p")
  (jw-indent-block (* -1 n)))

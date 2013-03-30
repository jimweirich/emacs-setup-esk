;;; yasnippet setup

;;(setq yas/text-popup-function          #'yas/dropdown-list-popup-for-template)
;;(setq yas/window-system-popup-function #'yas/dropdown-list-popup-for-template)

(require 'yasnippet)

(setq snippets-dir (concat user-specific-dir "/snippets"))

(defun jw-snippets ()
  (interactive)
  (setq yas/root-directory (list snippets-dir))
  (yas/reload-all))

(defun std-snippets ()
  (interactive)
  (setq yas/root-directory (cons snippets-dir yas/root-directory))
  (yas/reload-all))

(if (string= user-login-name "jim")
    (jw-snippets)
  (std-snippets))

;;; Should snippets minimize parens where possible?
(setq tm_minimize_paren t)

(defun snippet-paren-start ()
  (if tm_minimize_paren " " "("))

(defun snippet-paren-end ()
  (if tm_minimize_paren "" ")"))

(defun snippet-remove-empty-parens (text)
  (if (string-equal text "()") "()" text) )

(mapc '(lambda (hook) (add-hook hook 'yas/minor-mode-on))
      '(ruby-mode-hook))

;;; The default background tends to wash out the foreground color a
;;; bit.  Let's try something different.
(defface yas/field-highlight-face
  '((((class color) (background light)) (:background "DarkSeaGreen2"))
    (t (:background "maroon4")))
  "The face used to highlight a field of snippet.")

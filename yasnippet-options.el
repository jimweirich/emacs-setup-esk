;;; yasnippet setup

;;(setq yas/text-popup-function          #'yas/dropdown-list-popup-for-template)
;;(setq yas/window-system-popup-function #'yas/dropdown-list-popup-for-template)

(require 'yasnippet)

(setq snippets-dir (concat user-specific-dir "/snippets"))
(setq yas/root-directory (cons snippets-dir yas/root-directory))
(yas/reload-all)

(defun jw-snippets ()
  (interactive)
  (setq yas/root-directory (list snippets-dir))
  (yas/reload-all))

;;; The default background tends to wash out the foreground color a
;;; bit.  Let's try something different.
(defface yas/field-highlight-face
  '((((class color) (background light)) (:background "DarkSeaGreen2"))
    (t (:background "maroon4")))
  "The face used to highlight a field of snippet.")

(defun jw-red-cursor ()
  (interactive)
  (custom-set-faces
   '(cursor ((t (:background "#f00"))))))

(set-face-attribute 'default nil :height 160)

(require 'trilite)
(color-theme-trilite)

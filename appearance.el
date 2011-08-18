(set-face-attribute 'default nil :height 160)

(color-theme-twilight)

(defun jw-red-cursor ()
  (interactive)
  (custom-set-faces
   '(cursor ((t (:background "#f00"))))))
(jw-red-cursor)

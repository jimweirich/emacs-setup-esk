(defun jw-red-cursor ()
  (interactive)
  (custom-set-faces
   '(cursor ((t (:background "#f00"))))))

(defun ct-github () (interactive)
  (require 'color-theme-github)
  (color-theme-github))

(setq *jw-font-size* 16)

(defun jw-set-font-size (points)
  (setq *jw-font-size* points)
  (set-face-attribute 'default nil :height (* 10 *jw-font-size*)))

(defun jw-bigger-font ()
  (interactive)
  (jw-set-font-size (+ *jw-font-size* 2)))

(defun jw-smaller-font ()
  (interactive)
  (jw-set-font-size (- *jw-font-size* 2)))

(defun jw-standard-font ()
  (interactive)
  (jw-set-font-size 16))

(require 'trilite)
(ct-github)
(jw-standard-font)


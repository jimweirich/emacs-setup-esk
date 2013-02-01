(defun ct-github ()
  "Select the github theme."
  (interactive)
  (require 'color-theme-github)
  (color-theme-github))

(defun ct-day ()
  "Select the basic light theme."
  (interactive)
  (require 'color-theme-day)
  (color-theme-day))

(defun ct-night ()
  "Select the basic dark theme."
  (interactive)
  (require 'color-theme-night)
  (color-theme-night))

(setq *jw-font-size* 22)

(defun jw-set-font-size (points)
  "Set the font size to the given points."
  (setq *jw-font-size* points)
  (set-face-attribute 'default nil :height (* 10 *jw-font-size*))
  (message (concat "Font Size: " (number-to-string *jw-font-size*))))

(defun jw-bigger-font ()
  "Make the current font a bit bigger."
  (interactive)
  (jw-set-font-size (+ *jw-font-size* 2)))

(defun jw-smaller-font ()
  "Make the current font a bit smaller."
  (interactive)
  (jw-set-font-size (- *jw-font-size* 2)))

(defun jw-standard-font ()
  "Set the standard font face."
  (interactive)
  (jw-set-font-size 16))

(defun jw-face-query ()
  "Report the face at point."
  (interactive)
  (let ((face (get-text-property (point) 'face)))
    (if face (message (symbol-name face))
      (message "No Face"))))

(defun jw-face-query-at-mark ()
  "Report the face at point."
  (interactive)
  (let ((face (get-text-property (mark) 'face)))
    (if face (message (symbol-name face))
      (message "No Face"))))

(require 'jw-dark-theme)
;;;;;(jw-standard-font)

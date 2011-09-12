;;; colman -- Color Manipulation Functions

;;; Helper functions

(defun colman-h (r g b mn mx d)
  "Determine hue from RGB information (used in RGB>HSL conversion)."
  (cond ((= mx mn) 0)
        ((= mx r) (* 60 (/ (- g b) d)))
        ((= mx g) (+ (* 60 (/ (- b r) d)) 120))
        ((= mx b) (+ (* 60 (/ (- r g) d)) 240))
        (t 0)))

(defun colman-s (mn mx d l)
  "Determine saturation from RGB information (used in RGB>HSL conversion)."
  (cond ((= mx mn) 0)
        ((< l 0.5) (/ d (* 2 l)))
        (t (/ d (- 2 (* 2 l))))))

(defun colman-m2 (s l)
  "Determine m2 from the HSL information (used in HSL>RGB conversion)."
  (if (<= l 0.5) (* l (+ s 1))
    (+ l (- s (* l s)))))

(defun colman-m1 (l m2)
  "Determine m1 from the HSL information (used in HSL>RGB conversion)."
  (- (* l 2) m2))

(defun colman-hue-to-rgb (m1 m2 h)
  "Determine the RGB color value from the HSL information (used in HSL>RGB conversion)."
  (let ((two-thirds (/ 2.0 3.0)))
    (cond ((< h 0) (colman-hue-to-rgb m1 m2 (1+ h)))
          ((> h 1) (colman-hue-to-rgb m1 m2 (1- h)))
          ((< (* h 6) 1) (+ m1 (* (- m2 m1) h 6)))
          ((< (* h 2) 1) m2)
          ((< (* h 3) 2) (+ m1 (* (- m2 m1) (- two-thirds h) 6)))
          (t m1))))

(defun colman-clip (value mn mx)
  "Clip a value to a minimum and maximum."
  (min mx (max mn value)))

;;; Basic RGB <=> HSL Conversions

(defun colman-rgb-to-hsl (rgb)
  "Convert an RGB triplet into an HSL triplet."
  (let* ((r (/ (car rgb) 255.0))
         (g (/ (cadr rgb) 255.0))
         (b (/ (caddr rgb) 255.0))
         (mx (max r g b))
         (mn (min r g b))
         (d (- mx mn))
         (h (colman-h r g b mn mx d) )
         (l (/ (+ mx mn) 2.0))
         (s (colman-s mn mx d l)))
    (list (mod h 360)
          (* s 100)
          (* l 100))))

(defun colman-hsl-to-rgb (hsl)
  "Convert an HSL triplet to an RGB triplet."
  (let* ((h (/ (car hsl) 360.0))
         (s (/ (cadr hsl) 100.0))
         (l (/ (caddr hsl) 100.0))
         (m2 (colman-m2 s l))
         (m1 (colman-m1 l m2))
         (one_third (/ 1.0 3.0))
         (r (colman-hue-to-rgb m1 m2 (+ h one_third)))
         (g (colman-hue-to-rgb m1 m2 h))
         (b (colman-hue-to-rgb m1 m2 (- h one_third))))
    (list (fround (* r 255))
          (fround (* g 255))
          (fround (* b 255)))))

;;; Color String Conversion Functions

(defun colman-rgb-to-color (rgb)
  "Convert an RGB triplet into a color string."
  (let* ((r (car rgb))
         (g (cadr rgb))
         (b (caddr rgb)))
    (format "#%02x%02x%02x" r g b)))

(defun colman-color-to-rgb (color)
  "Convert a color string (e.g. #f0c023) into an RGB triplet."
  (mapcar '(lambda (pair)
             (string-to-number
              (substring color (car pair) (cadr pair))
              16))
          '((1 3) (3 5) (5 7))))

(defun colman-hsl-to-color (hsl)
  "Convert an HSL triplet to a color string."
  (colman-rgb-to-color (colman-hsl-to-rgb hsl)))

(defun colman-color-to-hsl (color)
  "Convert a color string to an HSL triplet."
  (colman-rgb-to-hsl (colman-color-to-rgb color)))

;;; Color manipulation: lighten and darken

(defun colman-lighten (color percent)
  "Lighten a color by a particular percentage."
  (let* ((hsl (colman-color-to-hsl color))
         (h (car hsl))
         (s (cadr hsl))
         (l (caddr hsl))
         (new-l (* l (/ (+ 100 percent) 100.0))))
    (colman-hsl-to-color (list h s (colman-clip new-l 0 100)))))

(defun colman-darken (color percent)
  "Darken a color by a particular percentage."
  (let* ((hsl (colman-color-to-hsl color))
         (h (car hsl))
         (s (cadr hsl))
         (l (caddr hsl))
         (new-l (* l (/ (- 100 percent) 100.0))))
    (colman-hsl-to-color (list h s (colman-clip new-l 0 100)))))

(defalias 'darken 'colman-darken)
(defalias 'lighten 'colman-lighten)

(provide 'colman)

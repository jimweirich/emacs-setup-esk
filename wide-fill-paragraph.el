;;; Wide fill paragraph function

(defun jw-wide-fill-paragraph ()
  "Fill a paragraph with an extremely wide fill column."
  (interactive)
  (let ((fill-column 1000000000))
    (fill-paragraph)))

(defun jw-fill-paragraph (arg)
  "Wrapping function that will either call the normal fill 
paragraph, or the wide version."
  (interactive "P")
  (if (null arg)
      (fill-paragraph)
    (jw-wide-fill-paragraph)))

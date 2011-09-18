;;; Some basic navigation customizations.

(setq line-move-visual nil)             ; Default to logical line movement

;;; The following function are like previous-line/next-line, but move
;;; visually (and do so without changing the default behaviour).

(defun previous-visual-line ()
  "Move to previous visual line, without effecting the default behavior."
  (interactive)
  (let ((line-move-visual t))
    (previous-line)))

(defun next-visual-line ()
  "Move to next visual line, without effecting the default behavior."
  (interactive)
  (let ((line-move-visual t))
    (next-line)))


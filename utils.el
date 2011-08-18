;;; Some utility function

(defun undos ()
  "Remove the <CR> in DOS files"
  (interactive)
  (save-excursion
    (goto-char (point-min))
    (replace-string "
" "") 
    (goto-char (point-min))
    (replace-string "" "") ))

(defun unansi ()
  "Remove the ansi markup in files"
  (interactive)
  (save-excursion
    (goto-char (point-min))
    (replace-regexp "\\([\\[0-9;\\]*m\\|\r\\)" "") 
    ))

(defun unhtml ()
  "Remove the HTML tags in a file"
  (interactive)
  (save-excursion
    (goto-char (point-min))
    (replace-regexp "<[^>]*>" "") 
    (goto-char (point-min))
    (replace-string "&nbsp;" " ")
    (goto-char (point-min))
    (replace-string "&lt;" "<")
    (goto-char (point-min))
    (replace-string "&gt;" ">")
    (goto-char (point-min))
    (replace-string "&amp;" "&") ))


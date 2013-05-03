;;; XMP Additions

(defun xmp-clear ()
  "Clear XMP comments."
  (interactive)
  (save-excursion
    (goto-char 0)
    (while (search-forward-regexp "# *=>" nil t)
      (if (not (looking-at " *\n"))
          (kill-line))))
  (save-excursion
    (goto-char 0)
    (while (search-forward-regexp "# *!>" nil t)
      (search-backward "#")
      (kill-line)))
  (save-excursion
    (goto-char 0)
    (while (search-forward-regexp "# *\\(>>\\|~>\\)" nil t)
      (beginning-of-line)
      (kill-line 1))))

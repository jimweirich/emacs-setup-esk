;;; Track directory changes

(defun jw-cd (dir)
  (shell-cd dir)
  (message dir) )

(defun jw-track-go-directories (string)
  (let ((out (replace-regexp-in-string "\n$" "" string)))
    (if (string-match "\\[cd: \\(.*\\)\\]" out)
        (let ((dir (substring out (match-beginning 1) (match-end 1))))
          (jw-cd dir) ))))

(add-hook 'comint-output-filter-functions 'jw-track-go-directories)

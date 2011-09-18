;;; Track directory changes

(defun jw-cd (dir)
  (shell-cd dir)
  (message dir) )

(defun jw-set-path (path)
  (setq exec-path (split-string path ":")))

(defun jw-track-go-directories (string)
  (let ((out (replace-regexp-in-string "\n$" "" string)))
    (cond ((string-match "\\[cd: \\(.*\\)\\]" out)
           (let ((dir (substring out (match-beginning 1) (match-end 1))))
             (jw-cd dir) ))
          ((string-match "\\[path: \\(.*\\)\\]" out)
           (let ((path (substring out (match-beginning 1) (match-end 1))))
             (jw-set-path path))))))

(add-hook 'comint-output-filter-functions 'jw-track-go-directories)

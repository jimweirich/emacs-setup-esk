;;; Source File Visiting
;;;
;;; Visit a source file 

(defun vs-current-line ()
  "Return the current line."
  (let
      ((bol (save-excursion (beginning-of-line)(point)))
       (eol (save-excursion (end-of-line)(point))))
    (dbg-inline "Current line: " (buffer-substring bol eol)) ))

(defun vs-generate-candidates (line)
  "Extract a list of file/line pairs from the given line of text."
  (vs-enhance-candidates (vs-generate-basic-candidates line)))

(defun vs-enhance-candidates (candidates)
  " Enhance the list of candidates by adding a relative path version for each absolute version."
  (cond ((null candidates) ())
        ((string-match "^/" (car (car candidates)))
         (cons (car candidates)
               (cons (list (vs-relative-path-for (caar candidates)) (cadar candidates))
                     (vs-enhance-candidates (cdr candidates)) ) ) )
        (t (cons (car candidates)
                 (vs-enhance-candidates (cdr candidates)) )) ))

(defun vs-relative-candidate-for (candidate)
  "The relative path version of a candiate.
Remove the leading / from the file name of the candidate."
  (cons (vs-relative-path-for (car candidate) (cdr candidate))) )

(defun vs-relative-path-for (absolute-path)
  "Remove the leading / on an absolute path."
  (substring absolute-path 1))

;; Setup the proper kind of file pattern
(cond
 ((file-exists-p "c:/")
  (let* ((non-dos "[^ \t\n\r\"'([<{]+")
         (dos-fn  (concat "[a-zA-Z]:\\(\\(" non-dos " " non-dos "\\)\\|" non-dos "\\)+"))
         (line-re "\\([0-9]+\\)"))
    (setq vs-flre (concat "\\(" dos-fn "\\):" line-re))
    (setq vs-flre-file 1)
    (setq vs-flre-line 4)
    (setq vs-lfre (concat "line #" line-re " of \\(" dos-fn "\\)"))
    (setq vs-lfre-line 1)
    (setq vs-lfre-file 2)
    ))
 (t
  (let* ((unix-fn "[^ \t\n\r\"'([<{]+")
         (line-re "\\([0-9]+\\)"))
    (setq vs-flre (concat "\\(" unix-fn "\\):" line-re))
    (setq vs-flre-file 1)
    (setq vs-flre-line 2)
    (setq vs-lfre (concat "line #" line-re " of \\(" unix-fn "\\)"))
    (setq vs-lfre-line 1)
    (setq vs-lfre-file 2)
    )))

(defun vs-generate-basic-candidates (line)
  (let ((start nil)
        (result nil))
    ;; If you could reference matched fragments with a name rather than a
    ;; number this could be one single, sweet, nested loop over a list of
    ;; patterns with a filename and a line in either order
    (while (string-match vs-flre line start) ; with file/line re
      (setq start (match-end 0))
      (setq result
            (cons (list 
                   (match-string vs-flre-file line)
                   (string-to-int (match-string vs-flre-line line)))
                  result)))
    (setq start nil)                         ; from the top
    (while (string-match vs-lfre line start) ; with line/file re
      (setq start (match-end 0))
      (setq result
            (cons (list
                   (match-string vs-lfre-file line)
                   (string-to-int (match-string vs-lfre-line line)))
                  result)))

    (dbg "Generated Candidates: " result)
    result))

(defun vs-parent-dir (path)
  "Return parent directory of path.
The parent of / is nil."
  (cond ((string-equal "/" path) nil)
        (t (file-name-directory (directory-file-name path))) ))

(defun vs-try-candidate (candidate)
  "Return a modified candidate that matches a real file, nil otherwise."
  (let ((candidate-file (car candidate)))
    (cond ((not (file-name-absolute-p candidate-file))
           (vs-try-candidate-in candidate (file-name-as-directory default-directory)))
          ((file-readable-p candidate-file) candidate)
          (t nil) )))

(defun vs-try-candidate-in (candidate dir)
  "Try the candidate dir and all its parents."
  (dbg "Trying candidate: " candidate " in " dir)
  (let ((candidate-file (concat dir (car candidate))))
    (cond ((null dir) nil)
          ((file-readable-p candidate-file)
           (list candidate-file (cadr candidate)))
          (t (vs-try-candidate-in candidate (vs-parent-dir dir))) )))

(defun vs-select-file-line (candidates)
  "Select a file/line candidate that references an existing file."
  (cond ((null candidates) nil)
        ((vs-try-candidate (car candidates)))
        (t (vs-select-file-line (cdr candidates))) ))

(defun vs-visit-source (&optional ask-user)
  "If the current line contains text like '../src/program.rb:34' or
'line #34 of app/views/users/show.html.erb', visit that file in
the other window and position point on that line. With a prefix
argument, prompt the user for the line to parse."
  (interactive "P")
  (let* ((line (if ask-user
                   (read-string "Source location: "
                                (and interprogram-paste-function
                                     (funcall interprogram-paste-function)))
                 (vs-current-line)))
         (candidates (vs-generate-candidates line))
         (file-line (vs-select-file-line candidates)))
    (cond (file-line
           (find-file-other-window (car file-line))
           (goto-line (cadr file-line)) )
          (t 
           (error "No source location on line.")) )))

;; vs-visit-source is traditionally bound to <f2>.  (see keybindings.el)

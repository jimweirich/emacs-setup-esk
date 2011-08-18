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
         (dos-fn  (concat "[a-zA-Z]:\\(\\(" non-dos " " non-dos "\\)\\|" non-dos "\\)+")))
    (setq vs-flre (concat "\\(" dos-fn "\\):\\([0-9]+\\)"))
    (setq vs-flre-file 1)
    (setq vs-flre-line 4)))
 (t
  (let* ((unix-fn "[^ \t\n\r\"'([<{]+"))
    (setq vs-flre (concat "\\(" unix-fn "\\):\\([0-9]+\\)"))
    (setq vs-flre-file 1)
    (setq vs-flre-line 2))))

(defun vs-generate-basic-candidates (line)
  (let ((start nil)
        (result nil))
    (while (string-match vs-flre line start)
      (setq start (match-end 0))
      (setq result
            (cons (list 
                   (substring line (match-beginning vs-flre-file) (match-end vs-flre-file))
                   (string-to-int (substring line
                                             (match-beginning vs-flre-line)
                                             (match-end vs-flre-line))))
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

(defun vs-visit-source ()
  "If the current line contains text like '../src/program.rb:34', visit 
that file in the other window and position point on that line."
  (interactive)
  (let* ((line (vs-current-line))
         (candidates (vs-generate-candidates line))
         (file-line (vs-select-file-line candidates)))
    (cond (file-line
           (find-file-other-window (car file-line))
           (goto-line (cadr file-line)) )
          (t 
           (error "No source location on line.")) )))

;; vs-visit-source is traditionally bound to <f2>.  (see keybindings.el)

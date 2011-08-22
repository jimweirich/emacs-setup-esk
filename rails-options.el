;;; Options for Rails functionality

;;; I don't like the rinari abbrevs, so ignore them

(provide 'rinari-abbrevs)
(require 'rinari)

;;; The rinari find view function doesn't recognize .erb files.  Here's a replacement.

(defun jw-find-view ()
  (interactive)
  (let* ((funname (which-function))
 	 (cls (rinari-make-dirname (rinari-name-components funname)))
	 (fn (and (string-match "#\\(.*\\)" funname) (match-string 1 funname)))
 	 (appdir (file-name-directory (directory-file-name (file-name-directory (buffer-file-name))))))
    (find-file (jw-choose-file
                (list
                 (concat appdir "views/" cls "/" fn ".html.erb")
                 (concat appdir "views/" cls "/" fn ".rhtml"))))))

(define-key ruby-mode-map "\C-c\C-v" 'jw-find-view)

(defun jw-file-name-sans-extension (filename)
  (if (string-match "\.html\.erb$" filename)
      (substring filename 0 (- (length filename) 9))
    (file-name-sans-extension filename)))

(defun jw-find-action ()
  (interactive)
  (let ((action (jw-file-name-sans-extension (file-name-nondirectory buffer-file-name))))
    (find-file (rhtml-controller-name-from-view))
    (beginning-of-buffer)
    (search-forward-regexp (concat "def *" action))
    (recenter)))

;;(define-key rhtml-mode-map "\C-c\C-v" 'jw-find-action)

(defun find-rails-root (&optional dir)
  (or dir (setq dir default-directory))
  (if (file-exists-p (concat dir "config/environment.rb"))
      dir
    (if (equal dir  "/")
	nil
      (find-rails-root (expand-file-name (concat dir "../"))))))

(defun routes ()
  (interactive)
  (find-file (concat (find-rails-root) "/config/routes.rb")))

(defun schema ()
  (interactive)
  (find-file (concat (find-rails-root) "/db/schema.rb")))

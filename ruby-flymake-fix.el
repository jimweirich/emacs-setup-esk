;;; Override the starter kits ruby flymake init to use Ruby 1.9

(setq flymake-ruby-command-name (concat user-specific-dir "/bin/autoruby"))

(defun flymake-ruby-init ()
  (let* ((temp-file (flymake-init-create-temp-buffer-copy
                     'flymake-create-temp-inplace))
         (local-file (file-relative-name
                      temp-file
                      (file-name-directory buffer-file-name))))
    ;; Invoke ruby with '-c' to get syntax checking
    (list flymake-ruby-command-name (list "-c" local-file))))

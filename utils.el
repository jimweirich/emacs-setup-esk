;;; Some utility function

(defun jw-choose-shell (n)
    (let* ((shell-name (concat "*shell-" (number-to-string n) "*"))
	  (buf (get-buffer shell-name)))
      (if (null buf)
	  (progn
	    (setq buf (shell))
	    (rename-buffer shell-name)))
      (pop-to-buffer buf)
      (goto-char (point-max))))

(defun jw-shell (n)
  (interactive "P")
  (cond ((null n) (jw-choose-shell 0))		; no prefix
	((atom n) (jw-choose-shell n))		; numeric prefix
	(t (jw-choose-shell 1)) ))		; ^U prefix

(defun send-shell-command (str)
  "Send commands to a shell process"
  (let* ((proc (get-buffer-process (current-buffer)))
	 (pmark (process-mark proc)))
    (insert-string str)
    (insert-string "\n")
    (set-marker pmark (point))
    (comint-send-string proc (concat str "\n"))))

(defun jw-suggest-width ()
  (interactive)
  (let ((wwidth (window-width (selected-window))))
    (concat "export COLUMNS=" (number-to-string wwidth))))

(defun jw-set-width ()
  (interactive)
  (send-shell-command (jw-suggest-width)))

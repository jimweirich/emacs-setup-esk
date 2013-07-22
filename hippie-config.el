;; Hippie expand: at times perhaps too hip

(dolist (f '(try-expand-line try-expand-list try-complete-file-name-partially try-complete-file-name))
  (setq hippie-expand-try-functions-list (delete f hippie-expand-try-functions-list)))

;; Add this back in at the end of the list.
(add-to-list 'hippie-expand-try-functions-list 'try-complete-file-name-partially t)
(add-to-list 'hippie-expand-try-functions-list 'try-complete-file-name t)

;;; This will allow :xyzzy to match when expanding xyz
;; (setq hippie-expand-dabbrev-as-symbol nil)


(require 'hippie-exp)

;;; This is a modified version of the search used by the dabbrev
;;; expanders to handle Ruby's colon in a special way. For some reason
;;; the Ruby-mode syntax table equates colons with underscores, which
;;; throws off the dabbrev search function (it thinks that the match
;;; is not at the beginning of a word). This is a one-line
;;; modification.

(defun he-dabbrev-search (pattern &optional reverse limit)
  (let ((result ())
	(regpat (cond ((not hippie-expand-dabbrev-as-symbol)
		       (concat "\\<" (regexp-quote pattern) "\\sw+"))
		      ((eq (char-syntax (aref pattern 0)) ?_)
		       (concat (regexp-quote pattern) "\\(\\sw\\|\\s_\\)+"))
		      (t
		       (concat "\\<" (regexp-quote pattern)
			       "\\(\\sw\\|\\s_\\)+")))))
    (while (and (not result)
		(if reverse
                    (re-search-backward regpat limit t)
                  (re-search-forward regpat limit t)))
      (setq result (buffer-substring-no-properties (match-beginning 0)
						   (match-end 0)))
      (if (or (and hippie-expand-dabbrev-as-symbol
		   (> (match-beginning 0) (point-min))
                   (not (eq ?: (char-after (1- (match-beginning 0))))) ; colon is special case -- JW
		   (memq (char-syntax (char-after (1- (match-beginning 0))))
			 '(?_ ?w)))
	      (he-string-member result he-tried-table t))
	  (setq result nil))) ; ignore if bad prefix or already in table
    result))

;; Setup delayed function to be run at the end of init.el.

(setq delayed-hook nil)

(defun run-delayed-hooks ()
  (run-hooks 'delayed-hook))

;; Put the following line in the init.el file.
;;    (run-delayed-hooks)

;;; Setup for Compilation Mode

;;; Compilation Mode Setups ==========================================

(load-library "compile")

;;; For some reason, the gnu regex is capturing leading white space.
(setq compilation-error-regexp-alist
      (remq 'gnu compilation-error-regexp-alist))

;; Ruby test unit patterns.
(add-to-list 'compilation-error-regexp-alist
             '("\\([^ \t:\\[]+\\):\\([0-9]+\\):in" 1 2))

(add-to-list 'compilation-error-regexp-alist
             '("test[a-zA-Z0-9_]*([A-Z][a-zA-Z0-9_]*) \\[\\(.*\\):\\([0-9]+\\)\\]:" 1 2))


;; FIC pattern
(add-to-list 'compilation-error-regexp-alist
             '("^\\([^ \t:\\[]+\\):\\([0-9]+\\):" 1 2))

;; Turn off trailing space notification

(add-hook 'compilation-mode-hook '(lambda () (setq show-trailing-whitespace nil)))

(require 'ansi-color)
(defun colorize-compilation-buffer ()
  (toggle-read-only)
  (ansi-color-apply-on-region (point-min) (point-max))
  (toggle-read-only))

(add-hook 'compilation-filter-hook 'colorize-compilation-buffer)

;;; Use the following hook to remove colorization from the compile
;;; buffer for tests. This is occassionally needed when projecting on
;;; a low contrast screen (red test failures don't show up so well).

; (add-hook 'compilation-filter-hook 'unansi)

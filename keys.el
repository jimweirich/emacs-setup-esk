;;; GLobal key bindings

;;; I really like the logical line bindings for C-n and C-p.  The
;;; standard next-line and previous-line bindings are left on the
;;; arrow keys.


;;; I really don't like the starter kit bindings for the following
;;; keys.
;;;
;;; Here's what I changed:
;;;
;;; * C-n/C-p Use logical lines rather than visual lines for
;;;           navigation.  Leave the visual navigation functions bound
;;;           to the arrow keys, so they are still availble if you
;;;           like them.
;;;
;;; * C-s The starter kit bound uses the regexp version of incremental
;;;       search.  I find that is rarely what I need, so I switched it
;;;       back to the normal incremental search.

(global-set-key (kbd "C-n") 'next-logical-line)
(global-set-key (kbd "C-p") 'previous-logical-line)
(global-set-key (kbd "C-s") 'isearch-forward)

;;; Goto line ... Very useful.

(global-set-key (kbd "M-g") 'goto-line)	; goto a line position

;;; Useful in fundamental elisp mode.

(global-set-key (kbd "s-j") 'eval-print-last-sexp)

;;; I do a lot of presentations, and easy changing of the font size is
;;; essential.  The first three bindings mimic the standard MAC
;;; bindings for font changes.  The last is for easy reseting to a
;;; stardard font size.

(global-set-key (kbd "s-=") 'jw-bigger-font)
(global-set-key (kbd "s-+") 'jw-bigger-font)
(global-set-key (kbd "s--") 'jw-smaller-font)
(global-set-key (kbd "s-|") 'jw-standard-font)

;;; Display the font type for the character at the cursor point.  This
;;; is useful for debugging color themes.

;; C-c *
(global-set-key (kbd "C-C ?") 'jw-face-query)

;; C-c C-*

(global-set-key (kbd "C-C C-t") 'etog-split-or-toggle)
(global-set-key (kbd "C-C C-d") 'delete-trailing-whitespace)

;; C-C c *
(global-set-key (kbd "C-C c a") 'jw-align)
(global-set-key (kbd "C-C c c") 'top-level)

;; C-C g *
(global-set-key (kbd "C-C g b") 'jw-mo-git-blame)
(global-set-key (kbd "C-C g g") 'magit-status)

;;; C-C t * -- Testing Commands
(global-set-key (kbd "C-C t F")   'jw-run-last-test-or-spec-file)
(global-set-key (kbd "C-C t M")   'jw-run-last-test-or-spec-method)
(global-set-key (kbd "C-C t c")   'jw-run-test-cruise)
(global-set-key (kbd "C-C t f")   'jw-run-test-or-spec-file)
(global-set-key (kbd "C-C t i")   'jw-run-test-integration)
(global-set-key (kbd "C-C t l")   'jw-run-test-functionals)
(global-set-key (kbd "C-C t m")   'jw-run-test-or-spec-method)
(global-set-key (kbd "C-C t r")   'jw-run-test-rake)
(global-set-key (kbd "C-C t s")   'toggle-style)
(global-set-key (kbd "C-C t t")   'jw-mark-for-testing)
(global-set-key (kbd "C-C t u")   'jw-run-test-units)
(global-set-key (kbd "C-C t w")   'jw-test-toggle-warnings)

(global-set-key (kbd "C-C t C-f") 'jw-run-last-test-or-spec-file)
(global-set-key (kbd "C-C t C-m") 'jw-run-last-test-or-spec-method)
(global-set-key (kbd "C-C t C-t") 'etog-clear-buffer-styles)
(global-set-key (kbd "C-C t C-s") 'toggle-debug)

(global-set-key (kbd "C-C t 1") (lambda () (interactive) (setq jw-test-single-window t))) ; pkg:testing
(global-set-key (kbd "C-C t 2") (lambda () (interactive) (setq jw-test-single-window nil))) ; pkg:testing

(global-set-key (kbd "C-z") 'scroll-down) ; I *hate* suspend bound on this key
(global-set-key (kbd "C-C SPC") 'jw-shell) ; override the default binding here
(global-set-key (kbd "C-C \\")  'codol-toggle)

;;; Function keys

(global-set-key (kbd "<f2>") 'vs-visit-source) 

(global-set-key (kbd "M-<f1>") (lambda () (interactive) (jw-shell 1)))
(global-set-key (kbd "M-<f2>") (lambda () (interactive) (jw-shell 2)))
(global-set-key (kbd "M-<f3>") (lambda () (interactive) (jw-shell 3)))
(global-set-key (kbd "M-<f4>") (lambda () (interactive) (jw-shell 4)))
(global-set-key (kbd "M-<f5>") (lambda () (interactive) (jw-shell 5)))
(global-set-key (kbd "M-<f6>") (lambda () (interactive) (jw-shell 6)))
(global-set-key (kbd "M-<f7>") (lambda () (interactive) (jw-shell 7)))

;;; Shell mode map

(add-hook 'shell-mode-hook
          (lambda ()
            (define-key shell-mode-map (kbd "C-c w") 'jw-set-width)
            (define-key shell-mode-map (kbd "C-c SPC") 'jw-shell)))

;;; Global key bindings

;;; Disable the right alt key as meta so that it can work for unicode
;;; characters.

(setq ns-right-alternate-modifier nil)

;;; * Arrows -- I prefer logical line navigation by default, but its
;;;             nice to have the the arrow keys use visual line
;;;             navigation.

(global-set-key (kbd "<down>") 'next-visual-line)
(global-set-key (kbd "<up>") 'previous-visual-line)

;;; * C-s The starter kit bound uses the regexp version of incremental
;;;       search.  I find that is rarely what I need, so I switched it
;;;       back to the normal incremental search.

(global-set-key (kbd "C-r") 'isearch-backward)
(global-set-key (kbd "C-s") 'isearch-forward)

;;; Meta *

(global-set-key (kbd "M-g") 'goto-line)
(global-set-key (kbd "M-q") 'jw-fill-paragraph)
(global-set-key (kbd "M-]") 'jw-indent-block)
(global-set-key (kbd "M-[") 'jw-outdent-block)

;;; Command *

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
(global-set-key (kbd "C-C f") 'find-file-in-git-repo)

;; C-c C-*

(global-set-key (kbd "C-C C-f") 'auto-fill-mode)
(global-set-key (kbd "C-C C-t") 'etog-split-or-toggle)
(global-set-key (kbd "C-C C-d") 'delete-trailing-whitespace)
(global-set-key (kbd "C-C C-r") 'isearch-backward-regexp)
(global-set-key (kbd "C-C C-s") 'isearch-forward-regexp)
(global-set-key (kbd "C-C C-v") 'xmp)

;; C-C c *
(global-set-key (kbd "C-C c a") 'jw-align)
(global-set-key (kbd "C-C c c") 'top-level)

;; C-C g *
(global-unset-key (kbd "C-C g"))        ; Something seems to be binding this
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

(global-set-key (kbd "C-C v") 'jw-eval-or-clear-buffer) ; pkg:eval-buffer

(global-set-key (kbd "C-C >") 'tags-reset-tags-tables)

(global-set-key (kbd "C-z") 'scroll-down) ; I *hate* suspend bound on this key
(global-set-key (kbd "C-C SPC") 'jw-shell) ; override the default binding here
(global-set-key (kbd "C-C \\")  'codol-toggle)

(global-set-key (kbd "C-x SPC")  'jw-shell) ; Sometimes C-C SPC is used in minor modes

;;; Function keys

(global-set-key (kbd "<f2>") 'vs-visit-source)
(global-set-key (kbd "<f6>") 'refresh-buffer)

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

(add-hook 'conf-mode-hook
          (lambda ()
            (define-key conf-mode-map (kbd "C-c SPC") 'jw-shell)))

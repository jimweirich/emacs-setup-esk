;;; GLobal key bindings

(global-set-key (kbd "C-C C-t") 'etog-split-or-toggle)
(global-set-key (kbd "C-C C-r") 'jw-red-cursor)

(global-set-key (kbd "C-C t s")   'toggle-style)
(global-set-key (kbd "C-C t w")   'jw-test-toggle-warnings)

;; C-C g
(global-set-key (kbd "C-C g b") 'jw-mo-git-blame)
(global-set-key (kbd "C-C g g") 'magit-status)

;;; C-C t -- Testing Commands
(global-set-key (kbd "C-C t F")    'jw-run-last-test-or-spec-file) ; pkg:testing
(global-set-key (kbd "C-C t M")    'jw-run-last-test-or-spec-method) ; pkg:testing
(global-set-key (kbd "C-C t c")    'jw-run-test-cruise) ; pkg:testing
(global-set-key (kbd "C-C t f")    'jw-run-test-or-spec-file) ; pkg:testing
(global-set-key (kbd "C-C t i")    'jw-run-test-integration) ; pkg:testing
(global-set-key (kbd "C-C t l")    'jw-run-test-functionals) ; pkg:testing
(global-set-key (kbd "C-C t m")    'jw-run-test-or-spec-method) ; pkg:testing
(global-set-key (kbd "C-C t r")    'jw-run-test-rake) ; pkg:testing
(global-set-key (kbd "C-C t s")    'toggle-style) ; pkg:testing
(global-set-key (kbd "C-C t t")    'jw-mark-for-testing) ; pkg:testing
(global-set-key (kbd "C-C t u")    'jw-run-test-units) ; pkg:testing
(global-set-key (kbd "C-C t w")    'jw-test-toggle-warnings) ; pkg:testing

(global-set-key (kbd "C-C t C-f")  'jw-run-last-test-or-spec-file) ; pkg:testing
(global-set-key (kbd "C-C t C-m")  'jw-run-last-test-or-spec-method) ; pkg:testing
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


;;; GLobal key bindings

(global-set-key (kbd "C-C C-t") 'etog-split-or-toggle)

(global-set-key (kbd "C-C t s")   'toggle-style)
(global-set-key (kbd "C-C t w")   'jw-test-toggle-warnings)

(global-set-key (kbd "C-C t C-t") 'etog-clear-buffer-styles)
(global-set-key (kbd "C-C t C-s") 'toggle-debug)

(global-set-key (kbd "C-z") 'scroll-down) ; I *hate* suspend bound on this key
(global-set-key (kbd "C-c SPC") 'jw-shell) ; override the default binding here

;;; Function keys

(global-set-key (kbd "<f2>") 'vs-visit-source) ; pkg:visit-source

;;; Shell mode map

(add-hook 'shell-mode-hook
          (lambda ()
            (define-key shell-mode-map (kbd "C-c w") 'jw-set-width)
            (define-key shell-mode-map (kbd "C-c SPC") 'jw-shell)))


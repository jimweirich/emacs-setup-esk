
(add-hook 'clojure-mode-hook
          '(lambda ()
             ;;; Override the eval buffer command for clojure mode
             (define-key clojure-mode-map "\C-cv" 'jw-eval-or-clear-buffer)))

;;; Put ido in vertical mode

;;; (require 'ido)
;;; (require 'ido-vertical-mode)
;;; (ido-vertical-mode)


;;;(esk-eval-after-init '(progn (ido-vertical-mode)))

(add-hook 'after-init-hook '(lambda () (ido-vertical-mode)))

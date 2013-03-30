;; Options for html-erb mode

(add-hook 'delayed-hook
          (lambda ()
            (require 'mmm-auto)

            (setq mmm-global-mode 'maybe)

            (mmm-add-mode-ext-class 'html-erb-mode "\\.html\\.erb\\'" 'erb)
            (mmm-add-mode-ext-class 'html-erb-mode "\\.jst\\.ejs\\'" 'ejs)
            (mmm-add-mode-ext-class 'html-erb-mode nil 'html-js)
            (mmm-add-mode-ext-class 'html-erb-mode nil 'html-css)

            (add-to-list 'auto-mode-alist '("\\.html\\.erb\\'" . html-erb-mode))
            (add-to-list 'auto-mode-alist '("\\.jst\\.ejs\\'"  . html-erb-mode))))


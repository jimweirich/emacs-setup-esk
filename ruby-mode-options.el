;;; Options for customizing Ruby model

(setq ruby-deep-indent-paren-style nil)


;;; Delete trailing spaces

(add-hook 'ruby-mode-hook '(lambda ()
                             (add-hook
                              (cond ((boundp 'before-save-hook)
                                     (make-local-variable 'before-save-hook)
                                     'before-save-hook)
                                    ((boundp 'write-contents-functions) 'write-contents-functions)
                                    ((boundp 'write-contents-hooks) 'write-contents-hooks))
                              'delete-trailing-whitespace)))

(add-hook 'ruby-mode-hook '(lambda () (auto-fill-mode -1)))

(add-hook 'js-mode-hook
          '(lambda ()
             (add-hook
              (cond ((boundp 'before-save-hook)
                     (make-local-variable 'before-save-hook)
                     'before-save-hook)
                    ((boundp 'write-contents-functions) 'write-contents-functions)
                    ((boundp 'write-contents-hooks) 'write-contents-hooks))
              'delete-trailing-whitespace)))

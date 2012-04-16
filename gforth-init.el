(defvar HOME (expand-file-name "~"))

;; ------
;; FORTH
;; ------

(defvar GFORTH_EL (concat HOME "/.emacs/jim/pkgs/gforth.el"))

(cond
 ((file-readable-p GFORTH_EL)
  (load-library GFORTH_EL)
  (autoload 'forth-mode GFORTH_EL)
  (setq auto-mode-alist (cons '("\\.fs\\'" . forth-mode) auto-mode-alist))
  (autoload 'forth-block-mode GFORTH_EL)
  (setq auto-mode-alist (cons '("\\.fb\\'" . forth-block-mode) auto-mode-alist))
  (add-hook 'forth-mode-hook
            (function (lambda ()
                        (setq forth-indent-level 4)
                        (setq forth-minor-indent-level 2)
                        (setq forth-hilight-level 3))))
  ))
